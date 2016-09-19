#!/bin/bash

eval "source /etc/profile.d/rvm.sh; mv /data/* .; polymarker.rb $@"
