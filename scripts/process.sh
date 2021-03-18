#! /bin/bash

set -euo pipefail

show_usage () {
    cat << EOF
Usage: $(basename "$0") -t <token> -e <endpoint> -c <config file> -a <alert files>

  -a <alert files, comma separated>   the alert templates to process
  -c <configuration file>             file used to fulfill the alert templates
  -d                                  cleanup processed yaml after each alert is pushed to wavefront
  -e <Wavefront instance>             the endpoint of your wavefront API instance
  -h                                  display this help and exit
  -s                                  suppress deployment to wavefront instance (for troubleshooting)
  -t <Wavefront API token>            the token used to access your wavefront instance

  Example:
  $(basename "$0") -t XVJSJUEF92347934jjsdldfdfd -e longboard.wavefront.com -c configs/prod.json -s -a bosh-unhealthy.json,pas-active-locks.json
  
EOF
}

opt_a=()    # list of alerts to process
opt_c=''    # configuration file
opt_d=false # cleanup processed files
opt_e=''    # wavefront instance
opt_s=true  # suppress deployment of alert to wavefront
opt_t=''    # wavefront token

while getopts "a:c:d:e:h:s:t" opt; do
    case $opt in
        a)  opt_a+=("$OPTARG")
            ;;
        c)  opt_c=$OPTARG
            ;;
        d)  opt_d=true
            ;;
        e)  opt_e=$OPTARG
            ;;
        s)  opt_s=false
            ;;
        t)  opt_t=$OPTARG
            ;;
        h)
            show_usage
            exit 0
            ;;
        ?)
            show_usage >&2
            exit 1
            ;;
    esac
done

if [ -z "$opt_c" ] || [ -z "$opt_e" ] || [ -z "$opt_t" ] || [[ ${#opt_a[@]} = 0 ]]; then
    show_usage
    exit 0
fi

if [[ ${#opt_a[@]} > 0 ]]; then
    for alert_file in "${opt_a[@]}"; do
        file=$(basename $alert_file)
        echo file
        result=$(jq -n --argfile config ./configs/$opt_c --from-file ./alerts/$file > ./processed/$file)
        echo $result
    done
fi

if [ "$opt_s" = false ]; then
    for filename in ./processed/*.json; do
        result=$(curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" --header "Authorization: Bearer $opt_t" -d @$filename "https://$opt_e/api/v2/alert")
        echo $result
        if [ "$opt_d" = true ]; then
            result=$(rm ./processed/$filename)
        fi
    done
fi