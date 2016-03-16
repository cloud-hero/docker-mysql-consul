#!/bin/bash

if [ -z "$SERVICE" ]; then
        echo "Please add your Service Tag"
        exit
   else
        sed 's|{{range service "replaceme"}}|{{range service "'$SERVICE'"}}|' -i $CT_FILE
fi

CONSUL_TEMPLATE_LOG=debug consul-template \
  -consul=$CONSUL \
  -template "$CT_FILE:$SQ_FILE:mysql -f -h$SQL_HOST -u$SQL_USER -p$SQL_PASS < $SQ_FILE";
