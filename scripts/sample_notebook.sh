#!/bin/bash

sudo /root/spark-2.2.0-bin-hadoop2.7/sbin/start-master.sh
exec /usr/local/bin/nimbix_notebook "$@"
