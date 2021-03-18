#! /bin/bash

for filename in ./alerts/*.json; do
    file=$(basename $filename)
    result=$(jq -n --argfile config ./configs/config.json --from-file ./alerts/$file > ./processed/$file)
    echo $result
done