*NOTE:* Supported images are available in the [official image library](https://hub.docker.com/_/neo4j/) on Docker Hub.
Please use those for production use.

Also see https://github.com/neo4j/docker-neo4j

# What does this contain?

The upstream neo4j PLUS the neo4j-shell-tools custom built on travis from
https://github.com/infothrill/neo4j-shell-tools

## Why?

Because the binaries referenced at https://github.com/jexp/neo4j-shell-tools do not
seem to expose the 'export-binary|import-binary' commands.

Not sure why. Probably should investigate and create a bug/pull request at
https://github.com/jexp/neo4j-shell-tools

