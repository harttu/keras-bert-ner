#!/bin/bash

for f in `ls *.out`
do
 awk -f jobgenreport.awk $f
done
