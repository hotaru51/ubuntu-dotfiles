#!/bin/sh

set -ue

pwd_dir=$(cd $(dirname $0); pwd)
backup_dir=${pwd_dir}/old

test ! -d ${backup_dir} && mkdir ${backup_dir}

# 初期の.bashrcをバックアップ
if [ -f ${HOME}/.bashrc ]; then
    cp -p ${HOME}/.bashrc ${backup_dir}
fi

# シンボリックリンク作成
ln -s ${pwd_dir}/.mybashrc ${HOME}/.mybashrc

# デフォルトの.bashrcにincludeする設定追記
cat <<'_EOT_' >> ${HOME}/.bashrc
if [ -f ${HOME}/.mybashrc ]; then
    . ${HOME}/.mybashrc
fi
_EOT_
