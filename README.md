# sh_base_env

Populate a local workspace:
```
sudo su -s /bin/bash -c "$(wget --no-cache -qO - "https://raw.githubusercontent.com/rnvandemark/sh_base_env/master/bin/sh_help_merge_standard_workspace.sh")" root '' "$USER" base /path/to/sh_ws
```

Optionally, build:
```
cd /path/to/sh_ws
colcon build --symlink-install
```
