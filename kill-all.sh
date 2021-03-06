#!/usr/bin/env bash

usage="$(basename "$0") [-h] [-g grafana port ] [ -p prometheus port ] -- kills existing Grafana and Prometheus Docker instances at given ports"

while getopts ':hg:p:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    g) GRAFANA_PORT=$OPTARG
       ;;
    p) PROMETHEUS_PORT=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

if [ -z $PROMETHEUS_PORT ]; then
    ./kill-prometheus.sh
else
    ./kill-prometheus.sh -p $PROMETHEUS_PORT
fi

if [ -z $GRAFANA_PORT ]; then
    ./kill-grafana.sh
else
    ./kill-grafana.sh -g $GRAFANA_PORT
fi




