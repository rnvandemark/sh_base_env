set -e

function sh_die() { echo "ERROR: $@" 1>&2; exit; }

[[ $# -eq 4 ]] || sh_die "Expected four input args."

# The user which will own all files
TARGET_USER="$1"
echo "## TARGET_USER=$TARGET_USER"
# A remote file to source, which contains definitions for the sh_do_* scripts
SH_FUNCS="$2"
echo "## SH_FUNCS=$SH_FUNCS"
# A local path to a smarthome workspace, e.g. /path/to/sh_ws
SH_WS_PATH="$3"
echo "## SH_WS_PATH=$SH_WS_PATH"
# A path to a rosinstall file to merge into the workspace
SH_ROSINSTALL_PATH="$4"
echo "## SH_ROSINSTALL_PATH=$SH_ROSINSTALL_PATH"

[[ -d "$SH_WS_PATH" ]] || sh_die "Could not find workspace path: '$SH_WS_PATH'"

echo "## Installing curl..."
apt-get install -y curl
echo "## Sourcing workspace functions..."
source <(curl -s "$SH_FUNCS")

echo "## Doing PRE package install... "
sh_do_pre_pkg_install
echo "## Doing package install... "
sh_do_pkg_install
echo "## Doing POST package install... "
sh_do_post_pkg_install

echo "## Merging workspace rosinstall... "
mkdir -p "${SH_WS_PATH}/src"
pushd "$SH_WS_PATH" >/dev/null
touch src/.rosinstall
wstool merge -t src "$SH_ROSINSTALL_PATH"
wstool update -t src "-j$(grep -c '^processor' /proc/cpuinfo)"
chown -R "${TARGET_USER}:${TARGET_USER}" *
popd >/dev/null

echo "## Doing POST workspace merge... "
sh_do_post_ws_merge
