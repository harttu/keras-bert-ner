#!/bin/bash
set -euxo pipefail

if [ $# -ne 4 ] 
then
	echo "Call: \$1: gpu/gputest \$2 memory size \$3 running time \$4 project name"
	return 1
fi

FILE=tmp.txt
if test -f "$FILE"; then
    rm "$FILE"
fi
touch "$FILE"
bash begin.sh $1 $2 $3 $4 >> "$FILE"
cat end.txt >> "$FILE"


