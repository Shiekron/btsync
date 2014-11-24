#!/bin/bash
SECRET="${@}"
: ${SECRET:=`/btsync --generate-secret`}

echo "Starting btsync with secret: $SECRET"

set -e
[ ! -f /data/btsync.conf ] && cat > /data/btsync.conf <<EOF
{
  "listening_port": 3369,
  "check_for_updates": false,
  "use_upnp": false,
  "webui": {
    "listen": "0.0.0.0:8888",
    "login": "admin",
    "password": "password",
  },
  "download_limit": 0,
  "upload_limit": 0,
  "shared_folders": [
        {
            "secret": "$SECRET",
            "dir": "/data",
            "use_relay_server": true,
            "use_tracker": true,
            "use_dht": false,
            "search_lan": true,
            "use_sync_trash": false
        }
                      ]
}
EOF

/btsync --nodaemon --config /data/btsync.conf
