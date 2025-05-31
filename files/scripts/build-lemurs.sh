#!/usr/bin/env bash
set -euo pipefail

cd /tmp
git clone https://github.com/coastalwhite/lemurs.git
cd lemurs

cargo build --release

cp -f "target/release/lemurs" "/usr/bin/lemurs"

mkdir -p "/etc/lemurs/wms"
mkdir -p "/etc/lemurs/wayland"

cp -f "extra/config.toml" "/etc/lemurs/config.toml"
cp -f "extra/xsetup.sh" "/etc/lemurs/xsetup.sh"
cp -f "extra/lemurs.pam" "/etc/pam.d/lemurs"

cp -f extra/lemurs.service /usr/lib/systemd/system/lemurs.service
