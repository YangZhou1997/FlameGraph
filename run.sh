# /bin/bash

folder=$2
mkdir -p $folder && cd $folder
sudo perf record -F 99 -p $1 -g -- sleep 60
sudo perf report -n --stdio -g caller > report_caller.perf
sudo perf report -n --stdio -g callee > report_callee.perf
sudo perf script > out.perf
../stackcollapse-perf.pl --all out.perf > out.folded
../flamegraph.pl out.folded > kernel.svg