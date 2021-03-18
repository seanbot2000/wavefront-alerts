# wavefront-alerts

This project has been created to provide and demonstrate the use of the wavefront api along with templating methods for mass creation of alerts. 

## Processing

The process.sh script located in the scripts directory is used to process and deploy user-provided alerts into a wavefront instance. Usage is as follows:

```
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
```

## Concourse
Part of this project is a demo pipeline located in the pipelines directory which could be used to feed configuration into concourse to create alerts within a pipeline.
