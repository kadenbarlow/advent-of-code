#! /usr/bin/env bash
docker run --rm -it -v $(pwd):/code --env-file=.env advent-of-code bash
