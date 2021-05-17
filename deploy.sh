#!/bin/bash

set -ue

work_dir=$(cd $(dirname $0); pwd)
backup_dir=${work_dir}/old
config_dir=${HOME}/.config

dotfiles=(
    ${config_dir}/starship.toml
)

test ! -d ${backup_dir} && mkdir ${backup_dir}
test ! -d ${config_dir} && mkdir ${config_dir}

# 初期の.bashrcをバックアップ
if [ -f ${HOME}/.bashrc ]; then
    cp -p ${HOME}/.bashrc ${backup_dir}
fi

# シンボリックリンク作成
ln -s ${work_dir}/.mybashrc ${HOME}/.mybashrc

デフォルトの.bashrcにincludeする設定追記
cat <<'_EOT_' >> ${HOME}/.bashrc
if [ -f ${HOME}/.mybashrc ]; then
    . ${HOME}/.mybashrc
fi
_EOT_

for file in "${dotfiles[@]}"
do
    # dotfileが存在する場合バックアップ
    if [ -f "${file}" ]; then
        mv ${file} ${backup_dir}
    fi

    # シンボリックリンクを作成
    ln -s ${work_dir}/$(basename ${file}) ${file}
done
