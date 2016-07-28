#!/bin/bash -e

# Quick hack to run an automatic import of file(s) on startup, if this is a fresh instance,
# Also can run arbitrary neo4j shell commands from file.

# docker run -v graphmls/:/initneo4j/ --rm infothrill/neo4j-shell-tools:2.3 /initneo4j.sh

if [ ! -d data/graph.db ];
then
    if [ -d /initneo4j/ ];
    then
        shopt -s nullglob
        for f in /initneo4j/*.graphml;
        do
        	./bin/neo4j-shell -path data/graph.db -c "import-graphml -i ${f} -t"
        done
        for f in /initneo4j/*.binary;
        do
            ./bin/neo4j-shell -path data/graph.db -c "import-binary -i ${f} -c"
        done
        for f in /initneo4j/*.neo4jshell;
        do
            ./bin/neo4j-shell -path data/graph.db -file ${f}
        done
    fi
fi
exec /docker-entrypoint.sh $@
