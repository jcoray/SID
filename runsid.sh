#!/bin/bash

#SID Setup and notes
#Network connections can be made to be persistent by beginning the stream name with ++ 
#downlink data from a server, you must use netcat
#only need one channel
# vtcard -B -vv -r96000 -d hw:0,0 @vlf
#USE sudo
vtcard -B -vv -A b=262144,p=2048 -r96000 -c1 -d hw:0,0 @vlf
vtwait -t @vlf
vtsid  -c mySID.conf @vlf
# vtsidgram -o png -s1200,800 raw/sid > spec.png

#vtsidplot -o png -m NAA -T2016-02-04  raw/sid > testplot.png
 
# At the end, send the data over the network to the server
# vtcat [options] [input [output]]


vtcard -Bvv -d hw:0,0 -b32 -r 192000 @raw,20,i4

echo "waiting for @raw..."

vtwait -t @raw || {
  echo "problem with buffer @raw" >&2
  exit 1
}

echo "@raw running"
vtcat -B @raw ++somewhere,someport,i4

