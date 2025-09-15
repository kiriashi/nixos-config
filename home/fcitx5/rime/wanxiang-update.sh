#!/usr/bin/env bash

set -euo pipefail

#### 配置 Rime 部署目录 ####
# 支持相对路径、绝对路径、拓展变量
# 例如 "/home/user/.local/share/fcitx5/rime"
# 例如 "$HOME/.local/share/fcitx5/rime"
# 例如 "${XDG_DATA_HOME:-$HOME/.local/share}/fcitx5/rime"

DEPLOY_DIR="$HOME/.local/share/fcitx5/rime"
######### 配置结束 #########

# 全局常量
readonly CNB_API="https://cnb.cool/amzxyz/rime-wanxiang/-/releases"
readonly SCHEMA_API="https://api.github.com/repos/amzxyz/rime_wanxiang/releases"
readonly GRAM_API="https://api.github.com/repos/amzxyz/RIME-LMDG/releases"
readonly TOOLS_API="https://api.github.com/repos/rimeinn/rime-wanxiang-update-tools/releases"
readonly FUZHU_LIST=("base" "flypy" "hanxin" "moqi" "tiger" "wubi" "zrm")
readonly DELETE_FILES=("简纯+.trime.yaml" "squirrel.yaml" "weasel.yaml"
  "README.md" "CHANGELOG.md" "version.txt"
  "custom_phrase.txt" "lua/tips/tips_user.txt预留的自定义文件")
readonly UPDATE_TOOLS_VERSION="v6.1.1"
readonly CONNECTION_TIMEOUT="10"
readonly MAX_RETRIES="3"

# 全局变量
TEMP_DIR=$(mktemp -d /tmp/wanxiang-update-XXXXXX)
NEEDED_DEPLOY="false"
COLOR_OUTPUT="true"

# 日志与错误处理
log() {
  if [[ "$COLOR_OUTPUT" == "true" ]]; then
    local red="\033[0;31m" green="\033[0;32m" yellow="\033[0;33m" nc="\033[0m"
    local level="$1" color="$nc"
    case "$level" in
    INFO) color="$green" ;;
    WARN) color="$yellow" ;;
    ERROR) color="$red" ;;
    esac
    shift
    printf "${color}[%s] %s${nc}\n" "$level" "$*"
  else
    local level="$1"
    shift
    printf "[%s] %s\n" "$level" "$*"
  fi
}

error_exit() {
  log ERROR "$*"
  cleanup
  exit 1
}

cleanup() {
  if [[ -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR" || log WARN "清理缓存文件失败"
  fi
}

# 带重试的curl请求 - 专门处理 set -e 环境
curl_with_retry() {
  local url="$1" output_file="$2" retries="0" success="false" curl_exit_code="0"

  # 确保输出目录存在
  mkdir -p "$(dirname "$output_file")"

  while [[ "$retries" -lt "$MAX_RETRIES" && "$success" == "false" ]]; do
    # 删除可能存在的部分下载文件
    if [[ -f "$output_file" ]]; then
      rm -f "$output_file" 2>/dev/null || :
    fi

    # 使用特殊语法防止 curl 失败导致脚本退出
    set +e # 临时禁用 set -e
    curl -f -sL --connect-timeout "$CONNECTION_TIMEOUT" -o "$output_file" "$url"
    curl_exit_code=$?
    set -e # 重新启用 set -e

    if [[ "$curl_exit_code" -eq "0" && -f "$output_file" ]]; then
      success="true"
    else
      retries=$((retries + 1))
      if [[ "$retries" -lt "$MAX_RETRIES" ]]; then
        log WARN "请求失败 (curl 退出代码: $curl_exit_code)，正在重试 ($retries/$MAX_RETRIES)..."
        sleep 2
      fi
    fi
  done

  if [[ "$success" == "false" ]]; then
    # 清理可能的部分文件
    if [[ -f "$output_file" ]]; then
      rm -f "$output_file"
    fi
    error_exit "无法连接到服务器: $url (已重试 $MAX_RETRIES 次，最后退出代码: $curl_exit_code)"
  fi

  return 0
}

# 检查网络连接
check_network_connection() {
  local mirror="$1"

  if [[ "$mirror" == "github" ]]; then
    log INFO "检查 GitHub 连接状态"
    set +e
    curl -sL --connect-timeout 5 "https://api.github.com" >/dev/null
    local github_api_status=$?
    curl -sL --connect-timeout 5 "https://github.com" >/dev/null
    local github_status=$?
    set -e

    if [[ "$github_api_status" -ne "0" ]]; then
      error_exit "无法连接到 GitHub API, curl 退出代码: $github_api_status, 请检查您的网络"
    elif [[ "$github_status" -ne "0" ]]; then
      error_exit "无法连接到 GitHub, curl 退出代码: $github_status, 请检查您的网络"
    fi
  elif [[ "$mirror" == "cnb" ]]; then
    log INFO "检查 CNB 连接状态"
    set +e
    curl -sL --connect-timeout 5 "https://cnb.cool" >/dev/null
    local cnb_status=$?
    set -e

    if [[ "$cnb_status" -ne "0" ]]; then
      error_exit "无法连接到 CNB, curl 退出代码: $cnb_status, 请检查您的网络"
    fi
  fi
}

deps_check() {
  for _cmd in curl jq unzip; do
    command -v "$_cmd" >/dev/null || error_exit "缺少必要依赖：$_cmd"
  done
}

fuzhu_check() {
  local fuzhu_check="$1"
  for _fuzhu in "${FUZHU_LIST[@]}"; do
    if [[ "$fuzhu_check" == "$_fuzhu" ]]; then
      return 0
    fi
  done
  return 1
}

show_help() {
  cat <<EOF
Usage: $0 [OPTIONS]

选项:
  --mirror [github|cnb]     选择下载源 (默认: github)
  --depdir DIR              设置部署目录 (必需)
  --inputime [fcitx5|ibus]  设置输入法平台
  --schema [base|pure|pro]  更新方案类型
  --fuzhu FUZHU             更新辅助码表 (base|flypy|hanxin|moqi|tiger|wubi|zrm)
  --dict                    更新词典
  --gram                    更新语法模型
  --no-color                禁用彩色输出
  --help                    显示此帮助信息

示例:
  $0 --depdir "\$HOME/.local/share/fcitx5/rime" --schema base --fuzhu base --dict
  $0 --mirror cnb --depdir "\$HOME/.config/ibus/rime" --schema pro --fuzhu flypy --gram

注意:
  必须至少指定一个更新项目: --schema, --dict 或 --gram
  使用 --schema 或 --dict 时必须同时使用 --fuzhu
EOF
}

exclude_file_check() {
  if [[ -f "$DEPLOY_DIR/user_exclude_file.txt" ]]; then
    mv "$DEPLOY_DIR/user_exclude_file.txt" "$DEPLOY_DIR/custom/user_exclude_file.txt"
    sed -i 's/user_exclude_file\.txt/custom\/user_exclude_file\.txt/g' \
      "$DEPLOY_DIR/custom/user_exclude_file.txt"
  fi # 处理旧版文件

  if [[ ! -f "$DEPLOY_DIR/custom/user_exclude_file.txt" ]]; then
    log WARN "$DEPLOY_DIR/custom/user_exclude_file.txt 文件不存在"
    log WARN "该文件用于在更新时保留必要的项目"
    log WARN "我们可以从模板生成一个包含大部分需要排除的项目的文件"
    log WARN "您需要生成一个预设文件吗？"

    local _createexcludefile
    read -rp "请输入 YES 或 NO (区分大小写): " _createexcludefile
    _createexcludefile="${_createexcludefile:-NO}"

    if [[ "$_createexcludefile" == "YES" ]]; then
      mkdir -p "$DEPLOY_DIR/custom"
      cat >"$DEPLOY_DIR/custom/user_exclude_file.txt" <<"EOF"
# 排除文件本身
custom/user_exclude_file.txt
# 用户数据库
lua/sequence.userdb
lua/sequence.txt
lua/input_stats.lua
zc.userdb
# 同步
installation.yaml
user.yaml
# custom 文件
default.custom.yaml
wanxiang_pro.custom.yaml
wanxiang_reverse.custom.yaml
wanxiang_mixedcode.custom.yaml
EOF
      log INFO "已创建 $DEPLOY_DIR/custom/user_exclude_file.txt 文件"
      log INFO "请查看该文件，确认所有项目正确后重新运行该脚本"
      error_exit "请查看 $DEPLOY_DIR/custom/user_exclude_file.txt 文件"
    else
      log WARN "您没有设置排除项目列表！"
      log WARN "您需要创建的文件为 $DEPLOY_DIR/custom/user_exclude_file.txt"
      log WARN "请在该文件中写入您需要排除的项目，每行一个"
      error_exit "$DEPLOY_DIR/custom/user_exclude_file.txt 文件不存在"
    fi
  fi

  if ! grep -Fxq "custom/user_exclude_file.txt" \
    "$DEPLOY_DIR/custom/user_exclude_file.txt"; then
    error_exit "您没有将 $DEPLOY_DIR/custom/user_exclude_file.txt 文件设为排除项！"
  fi
}

script_check() {
  local mirror="$1"
  if [[ "$UPDATE_TOOLS_VERSION" =~ ^"DEFAULT" ]]; then
    log WARN "您似乎正在使用错误的文件！"
    log WARN "请从 Release 页面下载正式版！"
    error_exit "终止操作"
  fi

  log INFO "工具当前版本: $UPDATE_TOOLS_VERSION"

  if [[ "$mirror" == "github" ]]; then
    # 检查网络连接状态
    check_network_connection "$mirror"

    log INFO "正在检查本工具是否存在更新"
    local local_version remote_version
    local_version="$UPDATE_TOOLS_VERSION"
    remote_version=$(
      curl -sL --connect-timeout 10 $TOOLS_API |
        jq -r '.[].tag_name' | grep -vE "rc" | sort -rV | head -n 1
    )

    if [[ "$remote_version" > "$local_version" ]]; then
      log WARN "检测到工具最新版本为: $remote_version, 建议更新后继续"
      log WARN "下载地址: https://github.com/rimeinn/rime-wanxiang-update-tools/releases/download/$remote_version/rime-wanxiang-update-linux"
    else
      log INFO "工具已是最新版本"
    fi
  elif [[ "$mirror" == "cnb" ]]; then
    # 检查网络连接状态
    check_network_connection "$mirror"

    log WARN "由于您正在使用镜像，无法检查本工具是否存在更新"
  fi
}

get_info() {
  local mirror="$1" version="$2" name="$3" info
  if [[ "$mirror" == "github" ]]; then
    info=$(
      jq -r --arg version "$version" --arg name "$name" '.[] |
      select( .tag_name == $version ) | .assets[] |
      select( .name | test( $name ) )' "$TEMP_DIR/github_$name.json"
    )
    echo "$info"
  elif [[ "$mirror" == "cnb" ]]; then
    info=$(
      jq -r --arg version "refs/tags/$version" --arg name "$name" '.releases[] |
      select( .tag_ref == $version ) | .assets[] |
      select( .name | test( $name ) )' "$TEMP_DIR/cnb.json"
    )
    echo "$info"
  fi
}

cache_api() {
  local mirror="$1" fuzhu="$2"
  if [[ "$mirror" == "github" ]]; then
    if [[ ! -f "$TEMP_DIR/github_$fuzhu.json" ]]; then
      local api_url
      if [[ "$fuzhu" != "gram" ]]; then
        api_url="$SCHEMA_API"
      else
        api_url="$GRAM_API"
      fi

      curl_with_retry "$api_url" "$TEMP_DIR/github_$fuzhu.json"
    fi
  elif [[ "$mirror" == "cnb" ]]; then
    if [[ ! -f "$TEMP_DIR/cnb.json" ]]; then
      curl_with_retry "$CNB_API" "$TEMP_DIR/cnb.json"
    fi
  fi
}

download_and_verify() {
  local url="$1" dest="$2" expected_size="$3" resource_name="$4"

  log INFO "正在下载 $resource_name"
  curl_with_retry "$url" "$dest"

  log INFO "正在验证文件完整性"
  local actual_size
  actual_size=$(stat -c %s "$dest" 2>/dev/null || echo 0)

  if [[ "$actual_size" -ne "$expected_size" ]]; then
    log ERROR "期望文件大小: $expected_size, 实际文件大小: $actual_size"
    # 删除损坏的文件
    rm -f "$dest"
    error_exit "$resource_name 下载出错，请重试！"
  fi
}

update_schema() {
  local mirror="$1" fuzhu="$2" gram="$3"
  # 缓存 API 响应
  cache_api "$mirror" "$fuzhu"

  # 获取本地版本号
  local local_version remote_version
  if [[ -f "$DEPLOY_DIR/lua/wanxiang.lua" ]]; then
    local_version=$(grep "wanxiang.version" "$DEPLOY_DIR/lua/wanxiang.lua" | awk -F '"' '{print $2}')
    [[ "$local_version" == v* ]] || local_version="v$local_version"
  else
    local_version="v0"
  fi

  # 获取远程版本号
  if [[ "$mirror" == "github" ]]; then
    remote_version=$(
      jq -r '.[].tag_name' "$TEMP_DIR/github_$fuzhu.json" |
        grep -vE "dict-nightly" | sort -rV | head -n 1
    )
  elif [[ "$mirror" == "cnb" ]]; then
    remote_version=$(
      jq -r '.releases[].tag_ref' \
        "$TEMP_DIR/cnb.json" | grep -vE "model" | sort -rV | head -n 1
    )
    remote_version="${remote_version#"refs/tags/"}"
  fi

  [[ "$remote_version" == v* ]] || remote_version="v$remote_version"

  if [[ "$remote_version" > "$local_version" ]]; then
    log INFO "远程方案文件版本号为 $remote_version, 以下内容为更新日志"
    local changelog
    if [[ "$mirror" == "github" ]]; then
      changelog=$(
        jq -r --arg version "$remote_version" '.[] |
        select( .tag_name == $version ) | .body' "$TEMP_DIR/github_$fuzhu.json"
      )
    elif [[ "$mirror" == "cnb" ]]; then
      changelog=$(
        jq -r --arg version "refs/tags/$remote_version" '.releases[] |
        select( .tag_ref == $version ) | .body' "$TEMP_DIR/cnb.json"
      )
    fi

    echo -e "$changelog" | sed -n '/## 📝 更新日志/,/## 🚀 下载引导/p' | head -n -1
    sleep 3

    log INFO "开始更新方案文件"
    local schemaurl schemaname remote_size
    if [[ "$mirror" == "github" ]]; then
      schemaurl=$(get_info "$mirror" "$remote_version" "$fuzhu" | jq -r '.browser_download_url')
      remote_size=$(get_info "$mirror" "$remote_version" "$fuzhu" | jq -r '.size')
    elif [[ "$mirror" == "cnb" ]]; then
      schemaurl=$(get_info "$mirror" "$remote_version" "$fuzhu" | jq -r '.path')
      schemaurl="https://cnb.cool$schemaurl"
      remote_size=$(get_info "$mirror" "$remote_version" "$fuzhu" | jq -r '.size_in_byte')
    fi

    schemaname=$(get_info "$mirror" "$remote_version" "$fuzhu" | jq -r '.name')

    download_and_verify "$schemaurl" "$TEMP_DIR/$schemaname" "$remote_size" "方案文件"

    log INFO "验证成功，开始更新方案文件"
    unzip -q "$TEMP_DIR/$schemaname" -d "$TEMP_DIR/${schemaname%.zip}"

    # 删除不需要的文件
    for _file in "${DELETE_FILES[@]}"; do
      if [[ -f "$TEMP_DIR/${schemaname%.zip}/$_file" ]]; then
        rm -rf "${TEMP_DIR:?}/${schemaname%.zip}/${_file:?}"
      fi
    done

    # 备份排除文件
    local exclude_file
    while IFS= read -r _line; do
      if [[ "$_line" != \#* && -n "$_line" ]]; then
        exclude_file="$_line"
        if [[ ! -e "$DEPLOY_DIR/$exclude_file" ]]; then
          log WARN "项目 $DEPLOY_DIR/$exclude_file 不存在，跳过备份！"
        else
          mkdir -p "$(dirname "$TEMP_DIR/${schemaname%.zip}/$exclude_file")"
          cp -rf "$DEPLOY_DIR/$exclude_file" "$TEMP_DIR/${schemaname%.zip}/$exclude_file"
        fi
      fi
    done <"$DEPLOY_DIR/custom/user_exclude_file.txt"

    # 单独处理语法模型
    if [[ "$gram" != "true" && -f "$DEPLOY_DIR/wanxiang-lts-zh-hans.gram" ]]; then
      cp -rf "$DEPLOY_DIR/wanxiang-lts-zh-hans.gram" \
        "$TEMP_DIR/${schemaname%.zip}/wanxiang-lts-zh-hans.gram"
    fi

    # 安全删除并复制文件
    if [[ -d "$DEPLOY_DIR" ]]; then
      rm -rf "${DEPLOY_DIR:?}"/*
    fi
    cp -rf "$TEMP_DIR/${schemaname%.zip}"/* "$DEPLOY_DIR/"

    NEEDED_DEPLOY="true"
    log INFO "方案文件更新成功"
  else
    log INFO "远程方案文件版本号为 $remote_version"
    log INFO "本地方案文件版本号为 $local_version, 您目前无需更新它"
  fi
}

update_dict() {
  local mirror="$1" fuzhu="$2"
  # 缓存 API 响应
  cache_api "$mirror" "$fuzhu"

  local local_date remote_date
  if [[ -f "$DEPLOY_DIR/dicts/chengyu.txt" ]]; then
    local_date=$(stat -c %Z "$DEPLOY_DIR/dicts/chengyu.txt")
  else
    local_date=0
  fi

  if [[ "$mirror" == "github" ]]; then
    remote_date=$(get_info "$mirror" "dict-nightly" "$fuzhu" | jq -r '.updated_at')
  elif [[ "$mirror" == "cnb" ]]; then
    remote_date=$(get_info "$mirror" "v1.0.0" "$fuzhu" | jq -r '.updated_at')
  fi

  remote_date=$(date -d "$remote_date" +%s)

  if [[ $remote_date -gt $local_date ]]; then
    local dicturl dictname remote_size
    if [[ "$mirror" == "github" ]]; then
      dicturl=$(get_info "$mirror" "dict-nightly" "$fuzhu" | jq -r '.browser_download_url')
      dictname=$(get_info "$mirror" "dict-nightly" "$fuzhu" | jq -r '.name')
      remote_size=$(get_info "$mirror" "dict-nightly" "$fuzhu" | jq -r '.size')
    elif [[ "$mirror" == "cnb" ]]; then
      dicturl=$(get_info "$mirror" "v1.0.0" "$fuzhu" | jq -r '.path')
      dicturl="https://cnb.cool$dicturl"
      dictname=$(get_info "$mirror" "v1.0.0" "$fuzhu" | jq -r '.name')
      remote_size=$(get_info "$mirror" "v1.0.0" "$fuzhu" | jq -r '.size_in_byte')
    fi

    download_and_verify "$dicturl" "$TEMP_DIR/$dictname" "$remote_size" "词典文件"

    log INFO "验证成功，开始更新词典文件"
    unzip -q "$TEMP_DIR/$dictname" -d "$TEMP_DIR"
    dictname="${dictname:2}" && dictname="${dictname%.zip}"

    mkdir -p "$DEPLOY_DIR/dicts"
    cp -rf "$TEMP_DIR/$dictname"/* "$DEPLOY_DIR/dicts"

    NEEDED_DEPLOY="true"
    log INFO "词典文件更新成功"
  else
    remote_date=$(date -d "@$remote_date" +"%Y-%m-%d %H:%M:%S")
    log INFO "远程词典文件最后更新于 $remote_date"
    local_date=$(date -d "@$local_date" +"%Y-%m-%d %H:%M:%S")
    log INFO "本地词典文件最后更新于 $local_date, 您目前无需更新它"
  fi
}

update_gram() {
  local mirror="$1"
  # 缓存 API 响应
  cache_api "$mirror" "gram"

  local local_date remote_date gramname="wanxiang-lts-zh-hans.gram"
  if [[ -f "$DEPLOY_DIR/$gramname" ]]; then
    local_date=$(stat -c %Z "$DEPLOY_DIR/$gramname")
  else
    local_date=0
  fi

  if [[ "$mirror" == "github" ]]; then
    remote_date=$(get_info "$mirror" "LTS" "gram" | jq -r '.updated_at')
  elif [[ "$mirror" == "cnb" ]]; then
    remote_date=$(get_info "$mirror" "model" "gram" | jq -r '.updated_at')
  fi

  remote_date=$(date -d "$remote_date" +%s)

  if [[ $remote_date -gt $local_date ]]; then
    local gramurl remote_size
    if [[ "$mirror" == "github" ]]; then
      gramurl=$(get_info "$mirror" "LTS" "gram" | jq -r '.browser_download_url')
      remote_size=$(get_info "$mirror" "LTS" "gram" | jq -r '.size')
    elif [[ "$mirror" == "cnb" ]]; then
      gramurl=$(get_info "$mirror" "model" "gram" | jq -r '.path')
      gramurl="https://cnb.cool$gramurl"
      remote_size=$(get_info "$mirror" "model" "gram" | jq -r '.size_in_byte')
    fi

    download_and_verify "$gramurl" "$TEMP_DIR/$gramname" "$remote_size" "语法模型"

    log INFO "验证成功，开始更新语法模型"
    cp -rf "$TEMP_DIR/$gramname" "${DEPLOY_DIR}/$gramname"

    NEEDED_DEPLOY="true"
    log INFO "语法模型更新成功"
  else
    remote_date=$(date -d "@$remote_date" +"%Y-%m-%d %H:%M:%S")
    log INFO "远程语法模型最后更新于 $remote_date"
    local_date=$(date -d "@$local_date" +"%Y-%m-%d %H:%M:%S")
    log INFO "本地语法模型最后更新于 $local_date, 您目前无需更新它"
  fi
}

main() {
  # 脚本退出清理临时目录
  trap cleanup EXIT INT TERM

  # 欢迎语
  log INFO "欢迎使用万象方案更新助手"

  # 检查是否为root用户
  if [[ "$EUID" -eq 0 ]]; then
    error_exit "请不要使用 root 身份运行该脚本！"
  fi

  # 检查必要的依赖
  deps_check

  # 处理用户输入
  local mirror="" depdir="" inputime="" schema="" fuzhu="" dict="false" gram="false"

  # 解析命令行参数
  while [[ "$#" -gt 0 ]]; do
    case $1 in
    --mirror)
      if [[ -n "$mirror" ]]; then
        error_exit "选项 mirror 需要参数！"
      else
        shift
      fi
      if [[ "$1" != "cnb" && "$1" != "github" ]]; then
        error_exit "选项 mirror 的参数只能为 github 或 cnb"
      else
        mirror="$1"
      fi
      ;;
    --depdir)
      if [[ -n "$depdir" ]]; then
        error_exit "选项 depdir 需要参数！"
      else
        shift
      fi
      DEPLOY_DIR="$1"
      ;;
    --inputime)
      if [[ -n "$inputime" ]]; then
        error_exit "选项 inputime 需要参数！"
      else
        shift
      fi
      if [[ "$1" != "fcitx5" && "$1" != "ibus" ]]; then
        error_exit "选项 inputime 的参数只能为 fcitx5 或 ibus"
      else
        inputime="$1"
      fi
      ;;
    --schema)
      if [[ -n "$schema" ]]; then
        error_exit "选项 schema 需要参数！"
      else
        shift
      fi
      if [[ "$1" != "base" && "$1" != "pure" && "$1" != "pro" ]]; then
        error_exit "选项 schema 的参数只能为 base/pure/pro 之一"
      else
        schema="$1"
      fi
      ;;
    --fuzhu)
      if [[ -n "$fuzhu" ]]; then
        error_exit "选项 fuzhu 需要参数！"
      else
        shift
      fi
      if fuzhu_check "$1"; then
        fuzhu="$1"
      else
        error_exit "选项 fuzhu 的参数只能为 ${FUZHU_LIST[*]} 其中之一"
      fi
      ;;
    --dict)
      dict="true"
      ;;
    --gram)
      gram="true"
      ;;
    --no-color)
      COLOR_OUTPUT="false"
      ;;
    --help)
      show_help
      exit 0
      ;;
    *)
      log WARN "未知参数: $1"
      log WARN "使用 --help 查看帮助信息"
      error_exit "参数输入错误: $1"
      ;;
    esac
    shift
  done

  # 判断是否设置了部署目录
  if [[ -z "$DEPLOY_DIR" ]]; then
    error_exit "请使用 --depdir 参数设置部署目录！"
  fi

  # 处理部署目录
  DEPLOY_DIR=$(eval echo "$DEPLOY_DIR")

  if [[ ! -d "$DEPLOY_DIR" ]]; then
    log WARN "部署目录 $DEPLOY_DIR 不存在，您要创建它吗？"
    read -rp "请输入 YES 或 NO (区分大小写): " _check
    if [[ "$_check" == "YES" ]]; then
      log WARN "您真的要创建该目录吗？您确定您的设置正确吗？"
      read -rp "请输入 YES 或 NO (区分大小写): " _check_again
      [[ "$_check_again" == "YES" ]] || error_exit "用户终止操作"
      mkdir -p "$DEPLOY_DIR"
    else
      error_exit "用户终止操作"
    fi
  fi

  # 排除项目列表文件是否存在
  exclude_file_check

  # 至少需要一个更新项目
  if [[ -z "$schema" && "$dict" == "false" && "$gram" == "false" ]]; then
    error_exit "请至少指定一个更新项目：--schema、--dict 或 --gram"
  fi

  # 检查 schema 和 fuzhu 是否同时存在
  if [[ -n "$schema" && -z "$fuzhu" ]]; then
    error_exit "选项 schema 与选项 fuzhu 必须同时使用"
  fi

  # 检查 dict 和 fuzhu 是否同时存在
  if [[ "$dict" == "true" && -z "$fuzhu" ]]; then
    error_exit "选项 dict 与选项 fuzhu 必须同时使用"
  fi

  # 检查当 schema 为 base 或 pure 时，fuzhu 是否也为 base
  if [[ "$schema" == "base" && "$fuzhu" != "base" ]]; then
    error_exit "当选项 schema 为 base 时，选项 fuzhu 必须为 base"
  elif [[ "$schema" == "pure" && "$fuzhu" != "base" ]]; then
    error_exit "当选项 schema 为 pure 时，选项 fuzhu 应为 base"
  fi

  [[ -n "$mirror" ]] || mirror="github"

  # 脚本自检
  script_check "$mirror"

  # 开始更新
  [[ -z "$schema" ]] || update_schema "$mirror" "$fuzhu" "$gram"
  [[ "$dict" == "false" ]] || update_dict "$mirror" "$fuzhu"
  [[ "$gram" == "false" ]] || update_gram "$mirror"

  # 自动部署
  if [[ "$NEEDED_DEPLOY" == "true" ]]; then
    if [[ "$inputime" == "fcitx5" ]]; then
      if command -v qdbus6 >/dev/null; then
        log INFO "更新完成。已检测到 Fcitx5 守护进程，正在自动部署"
        qdbus6 org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.SetConfig "fcitx://config/addon/rime/deploy" ""
      else
        log INFO "更新完成。请手动重新部署 Fcitx5"
      fi
    elif [[ "$inputime" == "ibus" ]]; then
      if command -v ibus-daemon >/dev/null; then
        log INFO "更新完成。已检测到 iBus 守护进程，正在自动部署"
        ibus-daemon -drx
      else
        log INFO "更新完成。请手动重新部署 iBus"
      fi
    else
      # 提示用户重新进行部署
      log INFO "更新完成。请手动重新部署 rime"
    fi
  else
    log INFO "您目前无需更新"
  fi
}

main "$@"
