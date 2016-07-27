#!/bin/bash -e

# Quick hack to run an automatic import of graphml file(s) on startup, if this is a fresh instance

# docker run -v graphmls/:/initneo4j/ --rm infothrill/neo4j-shell-tools:2.3 /initneo4j.sh

if [ ! -d data/graph.db ];
then
    if [ -d /initneo4j/ ];
    then
    	#ls /initneo4j/
        shopt -s nullglob
        for f in /initneo4j/*.graphml;
        do
        	./bin/neo4j-shell -path data/graph.db -c "import-graphml -i ${f} -t"
        done
    fi
fi
exec /docker-entrypoint.sh $@
