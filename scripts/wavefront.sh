#! /bin/bash

for filename in ./processed/*.json; do
    result=$(curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" --header "Authorization: Bearer $1" -d @$filename "https://longboard.wavefront.com/api/v2/alert")
    echo "Response from server"
    echo $result
done

exit