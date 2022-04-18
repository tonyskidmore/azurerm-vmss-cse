!/bin/bash

# run Post-generation scripts
# https://github.com/actions/virtual-environments/blob/main/docs/create-image-and-azure-resources.md#post-generation-scripts
find /opt/post-generation -mindepth 1 -maxdepth 1 -type f -name "*.sh" -exec bash {} \;


# get path information from /etc/environment
pathFromEnv=$(cut -d= -f2 /etc/environment | tail -1)
printf "pathFromEnv:\n %s\n" "$pathFromEnv"

# update /etc/sudoers secure_path
sed -i.bak "/secure_path/d" /etc/sudoers
echo "Defaults secure_path=$pathFromEnv" >> /etc/sudoers

# debug
cat /etc/sudoers
