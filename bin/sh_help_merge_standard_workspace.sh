set -e

TARGET_USER="$1"
SH_REPO_NAME="$2"
SH_WS_PATH="$3"
SH_BASE_BRANCH="${4:-master}"
SH_REPO_BRANCH="${5:-master}"

SH_REPO_REMOTE_PATH="https://raw.githubusercontent.com/rnvandemark/sh_${SH_REPO_NAME}_env/${SH_REPO_BRANCH}"

bash -c "$(wget -qO - "https://raw.githubusercontent.com/rnvandemark/sh_base_env/${SH_BASE_BRANCH}/bin/sh_merge_workspace.sh")" \
            '' \
            "$TARGET_USER" \
            "${SH_REPO_REMOTE_PATH}/bin/sh_do_merge_${SH_REPO_NAME}.sh" \
            "$SH_WS_PATH" \
            "${SH_REPO_REMOTE_PATH}/sh_${SH_REPO_NAME}.rosinstall"
