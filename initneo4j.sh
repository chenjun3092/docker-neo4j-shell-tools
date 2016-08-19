#!/bin/bash -e

# Quick hack to run an automatic import of file(s) on startup, if this is a fresh instance,
# Also can run arbitrary neo4j shell commands from file.

# docker run -v graphmls/:/initneo4j/ --rm infothrill/neo4j-shell-tools:2.3 /initneo4j.sh

if [ ! -d data/graph.db ];
then
    if [ -d /initneo4j/ ];
    then
        shopt -s nullglob
        # If import was failed we have to remove incorrectly created "data/graph.db" directory,
        # since Kubernetes restarts containers on failure and second start with non-empty
        # "data/graph.db" directory will be recognized as successful.
        trap 'echo "Import failed, removing the "data/graph.db" directory"; rm -rf "data/graph.db"' ERR
        for f in /initneo4j/*.sh;
        do
                chmod +x "$f"
                "$f"
        done
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
        # Unset trap defined above
        trap - ERR
    fi
fi
exec /docker-entrypoint.sh $@
