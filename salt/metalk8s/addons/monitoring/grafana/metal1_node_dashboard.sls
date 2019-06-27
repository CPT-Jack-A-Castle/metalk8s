#!kubernetes kubeconfig=/etc/kubernetes/admin.conf&context=kubernetes-admin@kubernetes
apiVersion: v1
data:
  node-exporter-full.json: |-
    {
      "__inputs": [
        {
          "name": "DS_PROMETHEUS",
          "label": "prometheus",
          "description": "",
          "type": "datasource",
          "pluginId": "prometheus",
          "pluginName": "Prometheus"
        }
      ],
      "__requires": [
        {
          "type": "grafana",
          "id": "grafana",
          "name": "Grafana",
          "version": "5.2.4"
        },
        {
          "type": "panel",
          "id": "graph",
          "name": "Graph",
          "version": "5.0.0"
        },
        {
          "type": "datasource",
          "id": "prometheus",
          "name": "Prometheus",
          "version": "5.0.0"
        },
        {
          "type": "panel",
          "id": "singlestat",
          "name": "Singlestat",
          "version": "5.0.0"
        }
      ],
      "annotations": {
        "list": [
          {
            "builtIn": 1,
            "datasource": "prometheus",
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
          }
        ]
      },
      "editable": true,
      "gnetId": 1860,
      "graphTooltip": 0,
      "hideControls": false,
      "id": null,
      "links": [],
      "refresh": false,
      "rows": [
        {
          "collapse": false,
          "height": 151,
          "panels": [
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Busy state of all CPU cores together",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 20,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 1,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "(((count(count(node_cpu_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}) by (cpu))) - avg(sum by (mode)(irate(node_cpu_seconds_total{mode='idle',instance=~\"$node:$port\",job=~\"$job\"}[5m])))) * 100) / count(count(node_cpu_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}) by (cpu))",
                  "hide": false,
                  "intervalFactor": 1,
                  "legendFormat": "",
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "85,95",
              "title": "CPU Busy",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 0,
              "description": "Non available RAM memory",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "hideTimeOverride": false,
              "id": 16,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "((node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_MemFree_bytes{instance=~\"$node:$port\",job=~\"$job\"}) / (node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} )) * 100",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                },
                {
                  "expr": "100 - ((node_memory_MemAvailable_bytes{instance=~\"$node:$port\",job=~\"$job\"} * 100) / node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"})",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 1,
                  "refId": "B",
                  "step": 900
                }
              ],
              "thresholds": "80,90",
              "title": "Used RAM Memory",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Used Swap",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 21,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "((node_memory_SwapTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_SwapFree_bytes{instance=~\"$node:$port\",job=~\"$job\"}) / (node_memory_SwapTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} )) * 100",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "10,25",
              "title": "Used SWAP",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Used Root FS",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 154,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "100 - ((node_filesystem_avail_bytes{instance=~\"$node:$port\",job=~\"$job\",mountpoint=\"/\",fstype!=\"rootfs\"} * 100) / node_filesystem_size_bytes{instance=~\"$node:$port\",job=~\"$job\",mountpoint=\"/\",fstype!=\"rootfs\"})",
                  "format": "time_series",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "80,90",
              "title": "Used Root FS",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Busy state of all CPU cores together (1 min average)",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 19,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 1,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "avg(node_load1{instance=~\"$node:$port\",job=~\"$job\"}) /  count(count(node_cpu_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}) by (cpu)) * 100",
                  "hide": false,
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "85, 95",
              "title": "CPU System Load (1m avg)",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Busy state of all CPU cores together (5 min average)",
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 155,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 1,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": true
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "avg(node_load5{instance=~\"$node:$port\",job=~\"$job\"}) /  count(count(node_cpu_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}) by (cpu)) * 100",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "85, 95",
              "title": "CPU System Load (5m avg)",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Basic CPU / Mem / Disk Gauge",
          "titleSize": "h6"
        },
        {
          "collapse": false,
          "height": 46,
          "panels": [
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "description": "Total number of CPU cores",
              "format": "short",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 14,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "count(count(node_cpu_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}) by (cpu))",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "",
              "title": "CPU Cores",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "Total RAM",
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 75,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "70%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "",
              "title": "Total RAM",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "Total SWAP",
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 18,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "70%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "node_memory_SwapTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "",
              "title": "Total SWAP",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "Total RootFS",
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 23,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 2,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "node_filesystem_size_bytes{instance=~\"$node:$port\",job=~\"$job\",mountpoint=\"/\",fstype!=\"rootfs\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "70,90",
              "title": "Total RootFS",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "System Load (1m avg)",
              "format": "short",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "id": 17,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "minSpan": 1,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "node_load1{instance=~\"$node:$port\",job=~\"$job\"}",
                  "hide": false,
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 900
                }
              ],
              "thresholds": "",
              "title": "System Load (1m avg)",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(245, 54, 54, 0.9)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(50, 172, 45, 0.97)"
              ],
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 1,
              "description": "System uptime",
              "format": "s",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "hideTimeOverride": true,
              "id": 15,
              "interval": null,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "null",
              "nullText": null,
              "postfix": "s",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "tableColumn": "",
              "targets": [
                {
                  "expr": "node_time_seconds{instance=~\"$node:$port\",job=~\"$job\"} - node_boot_time_seconds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "refId": "A",
                  "step": 1800
                }
              ],
              "thresholds": "",
              "title": "Uptime",
              "transparent": false,
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Basic CPU / Mem / Disk Info",
          "titleSize": "h6"
        },
        {
          "collapse": false,
          "height": "275",
          "panels": [
            {
              "aliasColors": {
                "Busy": "#EAB839",
                "Busy Iowait": "#890F02",
                "Busy other": "#1F78C1",
                "Idle": "#052B51",
                "Idle - Waiting for something to happen": "#052B51",
                "guest": "#9AC48A",
                "idle": "#052B51",
                "iowait": "#EAB839",
                "irq": "#BF1B00",
                "nice": "#C15C17",
                "softirq": "#E24D42",
                "steal": "#FCE2DE",
                "system": "#508642",
                "user": "#5195CE"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "Basic CPU info",
              "fill": 4,
              "id": 77,
              "legend": {
                "alignAsTable": false,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sideWidth": 250,
                "sort": null,
                "sortDesc": null,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": true,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "Busy Iowait",
                  "color": "#890F02"
                },
                {
                  "alias": "Idle",
                  "color": "#7EB26D"
                },
                {
                  "alias": "Busy System",
                  "color": "#EAB839"
                },
                {
                  "alias": "Busy User",
                  "color": "#0A437C"
                },
                {
                  "alias": "Busy Other",
                  "color": "#6D1F62"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum by (instance)(irate(node_cpu_seconds_total{mode=\"system\",instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Busy System",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "sum by (instance)(irate(node_cpu_seconds_total{mode='user',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Busy User",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "sum by (instance)(irate(node_cpu_seconds_total{mode='iowait',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Busy Iowait",
                  "refId": "E",
                  "step": 240
                },
                {
                  "expr": "sum by (instance)(irate(node_cpu_seconds_total{mode=~\".*irq\",instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Busy IRQs",
                  "refId": "F",
                  "step": 240
                },
                {
                  "expr": "sum (irate(node_cpu_seconds_total{mode!='idle',mode!='user',mode!='system',mode!='iowait',mode!='irq',mode!='softirq',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Busy Other",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='idle',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Idle",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "CPU Basic",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "transparent": false,
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "",
                  "logBase": 1,
                  "max": "100",
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "SWAP Used": "#BF1B00",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap Used": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "Basic memory usage",
              "fill": 4,
              "id": 78,
              "legend": {
                "alignAsTable": false,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "RAM Total",
                  "color": "#E0F9D7",
                  "fill": 0,
                  "stack": false
                },
                {
                  "alias": "RAM Cache + Buffer",
                  "color": "#052B51"
                },
                {
                  "alias": "RAM Free",
                  "color": "#7EB26D"
                },
                {
                  "alias": "Avaliable",
                  "color": "#DEDAF7",
                  "fill": 0,
                  "stack": false
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "RAM Total",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_MemFree_bytes{instance=~\"$node:$port\",job=~\"$job\"} - (node_memory_Cached_bytes{instance=~\"$node:$port\",job=~\"$job\"} + node_memory_Buffers_bytes{instance=~\"$node:$port\",job=~\"$job\"})",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "RAM Used",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_memory_Cached_bytes{instance=~\"$node:$port\",job=~\"$job\"} + node_memory_Buffers_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RAM Cache + Buffer",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_memory_MemFree_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RAM Free",
                  "refId": "F",
                  "step": 240
                },
                {
                  "expr": "(node_memory_SwapTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_SwapFree_bytes{instance=~\"$node:$port\",job=~\"$job\"})",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SWAP Used",
                  "refId": "G",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Basic",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Basic CPU / Mem Graph",
          "titleSize": "h6"
        },
        {
          "collapse": false,
          "height": "275",
          "panels": [
            {
              "aliasColors": {
                "Recv_bytes_eth2": "#7EB26D",
                "Recv_bytes_lo": "#0A50A1",
                "Recv_drop_eth2": "#6ED0E0",
                "Recv_drop_lo": "#E0F9D7",
                "Recv_errs_eth2": "#BF1B00",
                "Recv_errs_lo": "#CCA300",
                "Trans_bytes_eth2": "#7EB26D",
                "Trans_bytes_lo": "#0A50A1",
                "Trans_drop_eth2": "#6ED0E0",
                "Trans_drop_lo": "#E0F9D7",
                "Trans_errs_eth2": "#BF1B00",
                "Trans_errs_lo": "#CCA300",
                "recv_bytes_lo": "#0A50A1",
                "recv_drop_eth0": "#99440A",
                "recv_drop_lo": "#967302",
                "recv_errs_eth0": "#BF1B00",
                "recv_errs_lo": "#890F02",
                "trans_bytes_eth0": "#7EB26D",
                "trans_bytes_lo": "#0A50A1",
                "trans_drop_eth0": "#99440A",
                "trans_drop_lo": "#967302",
                "trans_errs_eth0": "#BF1B00",
                "trans_errs_lo": "#890F02"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "Basic network info per interface",
              "fill": 4,
              "id": 74,
              "legend": {
                "alignAsTable": false,
                "avg": false,
                "current": false,
                "hideEmpty": false,
                "hideZero": false,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "recv {{device}}",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "irate(node_network_transmit_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "trans {{device}} ",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Basic",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "transparent": false,
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "pps",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 3,
              "description": "Disk space used of all filesystems mounted",
              "fill": 4,
              "height": "",
              "id": 152,
              "legend": {
                "alignAsTable": false,
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": false,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "100 - ((node_filesystem_avail_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'} * 100) / node_filesystem_size_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'})",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}}",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk Space Used Basic",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "percent",
                  "label": null,
                  "logBase": 1,
                  "max": "100",
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Basic Net / Disk Info",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": 470,
          "panels": [
            {
              "aliasColors": {
                "Idle - Waiting for something to happen": "#052B51",
                "guest": "#9AC48A",
                "idle": "#052B51",
                "iowait": "#EAB839",
                "irq": "#BF1B00",
                "nice": "#C15C17",
                "softirq": "#E24D42",
                "steal": "#FCE2DE",
                "system": "#508642",
                "user": "#5195CE"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "",
              "fill": 4,
              "id": 3,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 250,
                "sort": null,
                "sortDesc": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": true,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "repeat": null,
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode=\"system\",instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "interval": "10s",
                  "intervalFactor": 2,
                  "legendFormat": "System - Processes executing in kernel mode",
                  "refId": "A",
                  "step": 20
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='user',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "User - Normal processes executing in user mode",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='nice',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Nice - Niced processes executing in user mode",
                  "refId": "C",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='idle',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Idle - Waiting for something to happen",
                  "refId": "F",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='iowait',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Iowait - Waiting for I/O to complete",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='irq',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Irq - Servicing interrupts",
                  "refId": "G",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='softirq',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Softirq - Servicing softirqs",
                  "refId": "H",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='steal',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Steal - Time spent in other operating systems when running in a virtualized environment",
                  "refId": "E",
                  "step": 240
                },
                {
                  "expr": "sum by (mode)(irate(node_cpu_seconds_total{mode='guest',instance=~\"$node:$port\",job=~\"$job\"}[5m])) * 100",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Guest - Time spent running a virtual CPU for a guest operating system",
                  "refId": "I",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "CPU",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "transparent": false,
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Percentage",
                  "logBase": 1,
                  "max": "100",
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap - Swap memory usage": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839",
                "Unused - Free memory unasigned": "#052B51"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "description": "",
              "fill": 4,
              "id": 24,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "sort": null,
                "sortDesc": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Harware Corrupted - *./",
                  "stack": false
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_MemTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_MemFree_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_Buffers_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_Cached_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_Slab_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_PageTables_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_SwapCached_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Apps - Memory used by user-space applications",
                  "refId": "Q",
                  "step": 240
                },
                {
                  "expr": "node_memory_PageTables_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "PageTables - Memory used to map between virtual and physical memory addresses",
                  "refId": "G",
                  "step": 240
                },
                {
                  "expr": "node_memory_SwapCached_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SwapCache - Memory that keeps track of pages that have been fetched from swap but not yet been modified",
                  "refId": "F",
                  "step": 240
                },
                {
                  "expr": "node_memory_Slab_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Slab - Memory used by the kernel to cache data structures for its own use (caches like inode, dentry, etc)",
                  "refId": "E",
                  "step": 240
                },
                {
                  "expr": "node_memory_Cached_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Cache - Parked file data (file content) cache",
                  "refId": "C",
                  "step": 240
                },
                {
                  "expr": "node_memory_Buffers_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Buffers - Block device (e.g. harddisk) cache",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_memory_MemFree_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Unused - Free memory unasigned",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "(node_memory_SwapTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"} - node_memory_SwapFree_bytes{instance=~\"$node:$port\",job=~\"$job\"})",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Swap - Swap space used",
                  "refId": "I",
                  "step": 240
                },
                {
                  "expr": "node_memory_HardwareCorrupted_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working",
                  "refId": "O",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Stack",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "receive_packets_eth0": "#7EB26D",
                "receive_packets_lo": "#E24D42",
                "transmit_packets_eth0": "#7EB26D",
                "transmit_packets_lo": "#E24D42"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 4,
              "id": 84,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive",
                  "refId": "O",
                  "step": 240
                },
                {
                  "expr": "irate(node_network_transmit_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit",
                  "refId": "P",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "Bps",
                  "label": "Bytes out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 3,
              "description": "",
              "fill": 4,
              "height": "",
              "id": 156,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": false,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filesystem_size_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'} - node_filesystem_avail_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}}",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk Space Used",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 229,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Read.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_reads_completed_total{instance=~\"$node:$port\",job=~\"$job\",device=~\"[a-z]*[a-z]\"}[5m])",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - Reads completed",
                  "refId": "A",
                  "step": 480
                },
                {
                  "expr": "irate(node_disk_writes_completed_total{instance=~\"$node:$port\",job=~\"$job\",device=~\"[a-z]*[a-z]\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Writes completed",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk IOps",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "iops",
                  "label": "IO read (-) / write (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "io time": "#890F02"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 3,
              "description": "",
              "fill": 4,
              "id": 42,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": null,
                "sortDesc": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*read*./",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_read_bytes_total{instance=~\"$node:$port\",job=~\"$job\",device=~\"[a-z]*[a-z]\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Successfully read bytes",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "irate(node_disk_written_bytes_total{instance=~\"$node:$port\",job=~\"$job\",device=~\"[a-z]*[a-z]\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Successfully written bytes",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "I/O Usage Read / Write",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": false,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes read (-) / write (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "ms",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ]
            },
            {
              "aliasColors": {
                "io time": "#890F02"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 3,
              "description": "",
              "fill": 4,
              "id": 127,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": null,
                "sortDesc": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_io_time_seconds_total{instance=~\"$node:$port\",job=~\"$job\",device=~\"[a-z]*[a-z]\"} [5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Time spent doing I/Os",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "I/O Usage Times",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": false,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Time",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "s",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "CPU Memory Net Disk",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 136,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Inactive_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Inactive - Memory which has been less recently used.  It is more eligible to be reclaimed for other purposes",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "node_memory_Active_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Active - Memory that has been used more recently and usually not reclaimed unless absolutely necessary",
                  "refId": "J",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Active / Inactive",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 135,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Committed_AS - *./"
                },
                {
                  "alias": "/.*CommitLimit - *./",
                  "color": "#BF1B00",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Committed_AS_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Committed_AS - Amount of memory presently allocated on the system",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "node_memory_CommitLimit_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "CommitLimit - Amount of  memory currently available to be allocated on the system",
                  "refId": "M",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Commited",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 191,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Inactive_file_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Inactive_file - File-backed memory on inactive LRU list",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "node_memory_Inactive_anon_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Inactive_anon - Anonymous and swap cache on inactive LRU list, including tmpfs (shmem)",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "node_memory_Active_file_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Active_file - File-backed memory on active LRU list",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "node_memory_Active_anon_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Active_anon - Anonymous and swap cache on active least-recently-used (LRU) list, including tmpfs",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Active / Inactive Detail",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "bytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "Total Swap": "#614D93",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 130,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Writeback_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Writeback - Memory which is actively being written back to disk",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "node_memory_WritebackTmp_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "WritebackTmp - Memory used by FUSE for temporary writeback buffers",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "node_memory_Dirty_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Dirty - Memory which is waiting to get written back to the disk",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Writeback and Dirty",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 138,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Mapped_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Mapped - Used memory in mapped pages files which have been mmaped, such as libraries",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "node_memory_Shmem_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Shmem - Used shared memory (shared between several processes, thus including RAM disks)",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Shared and Mapped",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "Total Swap": "#614D93",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 131,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_SUnreclaim_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SUnreclaim - Part of Slab, that cannot be reclaimed on memory pressure",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "node_memory_SReclaimable_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SReclaimable - Part of Slab, that might be reclaimed, such as caches",
                  "refId": "N",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Slab",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 70,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_VmallocChunk_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "VmallocChunk - Largest contigious block of vmalloc area which is free",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "node_memory_VmallocTotal_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "VmallocTotal - Total size of vmalloc memory area",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "node_memory_VmallocUsed_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "VmallocUsed - Amount of vmalloc area which is used",
                  "refId": "O",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Vmalloc",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 159,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Bounce_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Bounce - Memory used for block device bounce buffers",
                  "refId": "N",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Bounce",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 129,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Inactive *./",
                  "transform": "negative-Y"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_AnonHugePages_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "AnonHugePages - Memory in anonymous huge pages",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "node_memory_AnonPages_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "AnonPages - Memory in user pages not backed by files",
                  "refId": "G",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Anonymous",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 160,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_KernelStack_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "KernelStack - Kernel memory stack. This is not reclaimable",
                  "refId": "N",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Kernel",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#806EB7",
                "Total RAM + Swap": "#806EB7",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 140,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_HugePages_Free{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "HugePages_Free - Huge pages in the pool that are not yet allocated",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "node_memory_HugePages_Rsvd{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "HugePages_Rsvd - Huge pages for which a commitment to allocate from the pool has been made, but no allocation has yet been made",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "node_memory_HugePages_Surp{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "HugePages_Surp - Huge pages in the pool above the value in /proc/sys/vm/nr_hugepages",
                  "refId": "K",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory HugePages Counter",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#806EB7",
                "Total RAM + Swap": "#806EB7",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 71,
              "legend": {
                "alignAsTable": true,
                "avg": false,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_HugePages_Total{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "HugePages - Total size of the pool of huge pages",
                  "refId": "L",
                  "step": 4
                },
                {
                  "expr": "node_memory_Hugepagesize_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Hugepagesize - Huge Page size",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory HugePages Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": "",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 128,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": false,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_DirectMap1G{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "DirectMap1G - Amount of pages mapped as this size",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "node_memory_DirectMap2M_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "DirectMap2M - Amount of pages mapped as this size",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "node_memory_DirectMap4k_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "DirectMap4K - Amount of pages mapped as this size",
                  "refId": "L",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory DirectMap",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 137,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_Unevictable_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable - Amount of unevictable memory that can't be swapped out for a variety of reasons",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "node_memory_Mlocked_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "MLocked - Size of pages locked to memory using the mlock() system call",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Unevictable and MLocked",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "Total Swap": "#614D93",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 132,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_memory_NFS_Unstable_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "NFS Unstable - Memory in NFS pages sent to the server, but not yet commited to the storage",
                  "refId": "L",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory NFS",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Memory Detail Meminfo",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 176,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*out/",
                  "transform": "negative-Y"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgpgin{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pagesin - Page in operations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgpgout{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pagesout - Page out operations",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Pages In / Out",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 22,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*out/",
                  "transform": "negative-Y"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pswpin{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pswpin - Pages swapped in",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pswpout{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pswpout - Pages swapped out",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Pages Swap In / Out",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 197,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgdeactivate{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgdeactivate - Pages moved from active to inactive",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgfree{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgfree - Page free operations",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgactivate{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgactivate - Pages moved from inactive to active",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Operations",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 175,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "Pgfault - Page major and minor fault operations",
                  "fill": 0,
                  "stack": false
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgfault{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgfault - Page major and minor fault operations",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgmajfault{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgmajfault - Major page fault operations",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgfault{instance=~\"$node:$port\",job=~\"$job\"}[5m])  - irate(node_vmstat_pgmajfault{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgminfault - Minor page fault operations",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Faults",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Faults",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 172,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_kswapd_inodesteal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Kswapd_inodesteal - Pages reclaimed via kswapd inode freeing",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pginodesteal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgindesteal - Pages reclaimed via inode freeing",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Pages Reclaimed",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 184,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pageoutrun{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pageoutrun - Kswapd calls to page reclaim",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_allocstall{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "Allocstall - Direct reclaim calls",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_zone_reclaim_failed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "Zone_reclaim_failed - Zone reclaim failures",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Calls Reclaimed",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Calls",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 200,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgrotated{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgrotated - Pages rotated to tail of the LRU",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Rotate",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 170,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_drop_pagecache{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Drop_pagecache - Calls to drop page cache pages",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "node_vmstat_drop_slab{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Drop_slab - Calls to drop slab cache pages",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Drop",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Calls",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 183,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_slabs_scanned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Slabs_scanned - Slab pages scanned",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Scan Slab",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 181,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_cleared{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_cleared - Unevictable pages cleared",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_culled{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_culled - Unevictable pages culled",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_mlocked{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_mlocked - Unevictable pages mlocked",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_munlocked{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_munlocked - Unevictable pages munlocked",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_rescued{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_rescued- Unevictable pages rescued",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_scanned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable_pgs_scanned - Unevictable pages scanned",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_unevictable_pgs_stranded{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "unevictable_pgs_stranded - Unevictable pages stranded",
                  "refId": "H",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Unevictable Pages",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 174,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgalloc_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgalloc_dma - Dma mem page allocations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgalloc_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgalloc_dma32 - Dma32 mem page allocations",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgalloc_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgalloc_movable - Movable mem page allocations",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgalloc_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgalloc_normal - Normal mem page allocations",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Allocation",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 177,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgrefill_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgrefill_dma - Dma mem pages inspected in refill_inactive_zone",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgrefill_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgrefill_dma32 - Dma32 mem pages inspected in refill_inactive_zone",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgrefill_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgrefill_movable - Movable mem pages inspected in refill_inactive_zone",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgrefill_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgrefill_normal - Normal mem pages inspected in refill_inactive_zone",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Refill",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 179,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgsteal_direct_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_direct_dma - Dma mem pages stealed",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_direct_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_direct_dma32 - Dma32 mem pages scanned",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_direct_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_direct_movable - Movable mem pages scanned",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_direct_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_direct_normal - Normal mem pages scanned",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Steal Direct",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 198,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgsteal_kswapd_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_kswapd_dma - Dma mem pages scanned by kswapd",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_kswapd_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_kswapd_dma32 - Dma32 mem pages scanned by kswapd",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_kswapd_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_kswapd_movable - Movable mem pages scanned by kswapd",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgsteal_kswapd_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgsteal_kswapd_normal - Normal mem pages scanned by kswapd",
                  "refId": "I",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Steal Kswapd",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 192,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgscan_direct_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_direct_dma - Dma mem pages scanned",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_direct_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_direct_dma32 - Dma32 mem pages scanned",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_direct_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_direct_movable - Movable mem pages scanned",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_direct_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_direct_normal - Normal mem pages scanned",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_direct_throttle{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_direct_throttle - ",
                  "refId": "F",
                  "step": 2
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Scan Direct",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 178,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_pgscan_kswapd_dma{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_kswapd_dma - Dma mem pages scanned by kswapd",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_kswapd_dma32{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_kswapd_dma32 - Dma32 mem pages scanned by kswapd",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_kswapd_movable{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_kswapd_movable - Movable mem pages scanned by kswapd",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgscan_kswapd_normal{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgscan_kswapd_normal - Normal mem pages scanned by kswapd",
                  "refId": "I",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Scan Kswapd",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "Total Swap": "#614D93",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 169,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*fail*./",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_compact_free_scanned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_free_scanned - Pages scanned for freeing by compaction daemon",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_compact_isolated{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_isolated - Page isolations for memory compaction",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_compact_migrate_scanned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_migrate_scanned - Pages scanned for migration by compaction daemon",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Compact",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Active": "#99440A",
                "Buffers": "#58140C",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Dirty": "#6ED0E0",
                "Free": "#B7DBAB",
                "Inactive": "#EA6460",
                "Mapped": "#052B51",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "Slab_Cache": "#EAB839",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Total": "#511749",
                "Total RAM": "#052B51",
                "Total RAM + Swap": "#052B51",
                "Total Swap": "#614D93",
                "VmallocUsed": "#EA6460"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 189,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": null,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*fail*./",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_compact_fail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_fail - Unsuccessful compactions for high order allocations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_compact_stall{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_stall - Failures to even start compacting",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_compact_success{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Compact_sucess - Successful compactions for high order allocations",
                  "refId": "F",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Compactions",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Compactions",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 190,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_kswapd_high_wmark_hit_quickly{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Kswapd_high_wmark_hit_quickly - Times high watermark reached quickly",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "node_vmstat_kswapd_low_wmark_hit_quickly{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Kswapd_low_wmark_hit_quickly - Times low watermark reached quickly",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Kswapd Watermark",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 171,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_htlb_buddy_alloc_fail{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Htlb_buddy_alloc_fail - Huge TLB page buddy allocation failures",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "node_vmstat_htlb_buddy_alloc_success{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Htlb_buddy_alloc_success - Huge TLB page buddy allocation successes",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Buddy Alloc",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Allocations",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 173,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_numa_foreign{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_foreign - Foreign NUMA zone allocations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_hit{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_hit - Successful allocations from preferred NUMA zone",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_interleave{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_interleave - Interleaved NUMA allocations in each zone for each NUMA node",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_local{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_local - Successful allocations from local NUMA zone",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_miss{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_miss - Unsuccessful allocations from preferred NUMA zona",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_other{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_other - Unsuccessful allocations from local NUMA zone",
                  "refId": "I",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Numa Allocations",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Allocations",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 193,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Numa_pages_migrated - *./",
                  "fill": 0,
                  "stack": false
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_numa_pages_migrated{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_pages_migrated - NUMA page migrations",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgmigrate_fail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgmigrate_fail - Unsuccessful NUMA page migrations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_pgmigrate_success{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Pgmigrate_success - Successful NUMA page migrations",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Numa Page Migrations",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 194,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_numa_hint_faults{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_hint_faults - NUMA hint faults trapped",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_hint_faults_local{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_hint_faults_local - Hinting faults to local nodes",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Numa Hints",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "HInts",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 196,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 6,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_numa_pte_updates{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_pte_updates - NUMA page table entry updates",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_numa_huge_pte_updates{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "Numa_huge_pte_updates - NUMA huge page table entry updates",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Numa Table Updates",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Updates",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 199,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_thp_split{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_split - Transparent huge page splits",
                  "refId": "F",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory THP Splits",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Splits",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 182,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_workingset_activate{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Workingset_activate - Page activations to form the working set",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_workingset_nodereclaim{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Workingset_nodereclaim - NUMA node working set page reclaims",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_workingset_refault{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Workingset_refault - Refaults of previously evicted pages",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Workingset",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 180,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_vmstat_thp_collapse_alloc{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_collapse_alloc - Transparent huge page collapse allocations",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_thp_collapse_alloc_failed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_collapse_alloc_failed - Transparent huge page collapse allocation failures",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_thp_zero_page_alloc{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_zero_page_alloc - Transparent huge page zeroed page allocations",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_thp_zero_page_alloc_failed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_zero_page_alloc_failed - Transparent huge page zeroed page allocation failures",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_thp_fault_alloc{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_fault_alloc - Transparent huge page fault allocations",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_vmstat_thp_fault_fallback{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "Thp_fault_fallback - Transparent huge page fault fallbacks",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory THP Allocations",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Allocations",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Memory Detail Vmstat",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 185,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_active_anon{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Active_anon - Active anonymous memory pages",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_active_file{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Active_file - Active file memory memory pages",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Active",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 228,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_inactive_anon{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Inactive_anon - Inactive anonymous memory pages in each zone for each NUMA node",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_inactive_file{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Inactive_file - Inactive file memory pages in each zone for each NUMA node",
                  "refId": "D",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Inactive",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 188,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_slab_reclaimable{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Reclaimable - Instantaneous reclaimable slab pages",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_slab_unreclaimable{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unreclaimable - Instantaneous unreclaimable slab pages",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Reclaimed / Unreclaimed",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 186,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_free_pages{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Free_pages - Free pages",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_written{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Written - Pages written out in each zone for each NUMA node",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Free / Written",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 218,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_dirty{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Dirty - Pages in dirty state",
                  "refId": "C",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_bounce{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Bounce - Bounce buffer pages",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Dirty / Bounce",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 201,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_unevictable{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unevictable - Unevictable pages",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_mlock{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Mlock - Pages under mlock",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Pages Unevictable / Mlock",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 214,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_shmem{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Shmem - Shared memory pages",
                  "refId": "H",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_mapped{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Mapped - Mapped pagecache pages in each zone for each NUMA node",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Shmem / Mapped",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 212,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_kernel_stack{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Kernel_stack - Pages of kernel stack",
                  "refId": "F",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Kernel_stack",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 203,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_writeback{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Writeback - Writeback pages",
                  "refId": "G",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_writeback_temp{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Writeback_temp - Temporary writeback pages",
                  "refId": "H",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Pages Writeback",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 205,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_file_pages{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "File_pages - File pagecache pages in each zone for each NUMA node",
                  "refId": "F",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page File_pages",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 206,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_dirty_background_threshold{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Dirty_background_threshold - Background writeback threshold",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_dirty_threshold{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Dirty_threshold - Dirty throttling threshold",
                  "refId": "E",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Dirty Threshold",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 208,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_unstable{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Unstable - Pages unstable state in each zone for each NUMA node",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_dirtied{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Dirtied - Pages entering dirty state in each zone for each NUMA node",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Unstable / Dirtied",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 209,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_page_table_pages{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Page_table_pages - Page table pages in each zone for each NUMA node",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Page_table_pages",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 217,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_alloc_batch{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Alloc_batch - Pages allocated to other zones due to insufficient memory for each zone for each NUMA node",
                  "refId": "D",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Alloc_batch",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 213,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_isolated_anon{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Isolated_anon - Isolated anonymous memory pages in each zone for each NUMA node",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_isolated_file{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Isolated_file - Isolated file memory pages in each zone for each NUMA node",
                  "refId": "E",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Isolated",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 216,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_anon_pages{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Anon_pages - Anonymous mapped pagecache pages in each zone for each NUMA node",
                  "refId": "E",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_anon_transparent_hugepages{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Anon_transparent_hugepages - Anonymous transparent huge pages in each zone for each NUMA node",
                  "refId": "F",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Anon",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "Apps": "#629E51",
                "Buffers": "#614D93",
                "Cache": "#6D1F62",
                "Cached": "#511749",
                "Committed": "#508642",
                "Free": "#0A437C",
                "Harware Corrupted - Amount of RAM that the kernel identified as corrupted / not working": "#CFFAFF",
                "Inactive": "#584477",
                "PageTables": "#0A50A1",
                "Page_Tables": "#0A50A1",
                "RAM_Free": "#E0F9D7",
                "Slab": "#806EB7",
                "Slab_Cache": "#E0752D",
                "Swap": "#BF1B00",
                "Swap_Cache": "#C15C17",
                "Swap_Free": "#2F575E",
                "Unused": "#EAB839"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 2,
              "fill": 2,
              "id": 204,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 350,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_vmstat_nr_free_cma{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Free_cma - Free Contiguous Memory Allocator pages in each zone for each NUMA node",
                  "refId": "G",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_vmscan_write{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Vmscan_write - Pages written by VM scanner from LRU",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_vmstat_nr_vmscan_immediate_reclaim{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 2,
                  "legendFormat": "Immediate_reclaim - Prioritise for reclaim when writeback ends in each zone for each NUMA node",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Memory Page Misc",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Pages",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Memory Detail Vmstat Counters",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 8,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "repeat": null,
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_context_switches_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Context switches",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "irate(node_intr_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Interrupts",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Context Switches / Interrupts",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 7,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "repeat": null,
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_load1{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 4,
                  "legendFormat": "Load 1m",
                  "refId": "A",
                  "step": 480
                },
                {
                  "expr": "node_load5{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 4,
                  "legendFormat": "Load 5m",
                  "refId": "B",
                  "step": 480
                },
                {
                  "expr": "node_load15{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 4,
                  "legendFormat": "Load 15m",
                  "refId": "C",
                  "step": 480
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "System Load",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Load",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 259,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Critical*./",
                  "color": "#E24D42",
                  "fill": 0
                },
                {
                  "alias": "/.*Max*./",
                  "color": "#EF843C",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_interrupts_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ type }} - {{ info }}",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Interrupts Detail",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 64,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Max*./",
                  "color": "#890F02",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "process_max_fds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Maximum open file descriptors",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "process_open_fds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Open file descriptors",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "File Descriptors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Descriptors",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 151,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_entropy_available_bits{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Entropy available to random number generators",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Entropy",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Entropy",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 62,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_procs_blocked{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Processes blocked waiting for I/O to complete",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_procs_running{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Processes in runnable state",
                  "refId": "B",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Processes State",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Processes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 148,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_forks_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "Processes forks second",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Processes  Forks",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Forks / sec",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 149,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "process_virtual_memory_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Processes virtual memory size in bytes",
                  "refId": "C",
                  "step": 240
                },
                {
                  "expr": "process_resident_memory_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Processes resident memory size in bytes",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Processes Memory",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "decbytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 168,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Variation*./",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_timex_sync_status{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Is clock synchronized to a reliable server (1 = yes, 0 = no)",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_timex_frequency_adjustment_ratio{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Local clock frequency adjustment",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Time Syncronized Status",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 260,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Variation*./",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_timex_estimated_error_seconds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Estimated error in seconds",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_timex_offset_seconds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Time offset in between local system and reference clock",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_timex_maxerror_seconds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "Maximum error in seconds",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Time Syncronized Drift",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Seconds",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 158,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Critical*./",
                  "color": "#E24D42",
                  "fill": 0
                },
                {
                  "alias": "/.*Max*./",
                  "color": "#EF843C",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_hwmon_temp_celsius{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ chip }} {{ sensor }} temp",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_hwmon_temp_crit_alarm_celsius{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": true,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ chip }} {{ sensor }} Critical Alarm",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_hwmon_temp_crit_celsius{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ chip }} {{ sensor }} Critical",
                  "refId": "C",
                  "step": 240
                },
                {
                  "expr": "node_hwmon_temp_crit_hyst_celsius{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": true,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ chip }} {{ sensor }} Critical Historical",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_hwmon_temp_max_celsius{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": true,
                  "interval": "",
                  "intervalFactor": 2,
                  "legendFormat": "{{ chip }} {{ sensor }} Max",
                  "refId": "E",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Hardware temperature monitor",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "celsius",
                  "label": "Temperature",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "System Detail",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 9,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "repeat": null,
              "seriesOverrides": [
                {
                  "alias": "/.*Read.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_reads_completed_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - Reads completed",
                  "refId": "A",
                  "step": 8
                },
                {
                  "expr": "irate(node_disk_writes_completed_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Writes completed",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk IOps Completed",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "iops",
                  "label": "IO read (-) / write (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 33,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Read.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_read_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - Read bytes",
                  "refId": "A",
                  "step": 8
                },
                {
                  "expr": "irate(node_disk_written_bytes_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Written bytes",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk R/W Data",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "Bps",
                  "label": "Bytes read (-) / write (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 3,
              "id": 37,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Read.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_read_time_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "hide": false,
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - Read time",
                  "refId": "A",
                  "step": 8
                },
                {
                  "expr": "irate(node_disk_write_time_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Write time",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk R/W Time",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Time. read (-) / write (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 35,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_io_time_weighted_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - IO time weighted",
                  "refId": "A",
                  "step": 8
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk IOs Weighted",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Time",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 133,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Read.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_reads_merged_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Read merged",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_disk_writes_merged_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Write merged",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk R/W Merged",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "iops",
                  "label": "I/Os",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 3,
              "id": 36,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_io_time_seconds_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - IO time",
                  "refId": "A",
                  "step": 8
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Time Spent Doing I/Os",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Time",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 34,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#BA43A9"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_disk_io_now{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 4,
                  "legendFormat": "{{device}} - IO now",
                  "refId": "A",
                  "step": 8
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Disk IOs Current in Progress",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "iops",
                  "label": "I/Os",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 66,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*sda_.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*sdb_.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*sdc_.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*sdd_.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*sde_.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*sda1.*/",
                  "color": "#584477"
                },
                {
                  "alias": "/.*sda2_.*/",
                  "color": "#B7DBAB"
                },
                {
                  "alias": "/.*sda3_.*/",
                  "color": "#F4D598"
                },
                {
                  "alias": "/.*sdb1.*/",
                  "color": "#0A50A1"
                },
                {
                  "alias": "/.*sdb2.*/",
                  "color": "#BF1B00"
                },
                {
                  "alias": "/.*sdb3.*/",
                  "color": "#E0752D"
                },
                {
                  "alias": "/.*sdc1.*/",
                  "color": "#962D82"
                },
                {
                  "alias": "/.*sdc2.*/",
                  "color": "#614D93"
                },
                {
                  "alias": "/.*sdc3.*/",
                  "color": "#9AC48A"
                },
                {
                  "alias": "/.*sdd1.*/",
                  "color": "#65C5DB"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*sdd3.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*sde1.*/",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "/.*sdd2.*/",
                  "color": "#FCEACA"
                },
                {
                  "alias": "/.*sde3.*/",
                  "color": "#F9E2D2"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_textfile_scrape_error{instance=~\"$node:$port\",job=~\"$job\"}",
                  "intervalFactor": 4,
                  "legendFormat": "Textfile scrape error (1 = true)",
                  "refId": "A",
                  "step": 8
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Open Error File",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Errors",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Disk Detail",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": 391,
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": 3,
              "description": "",
              "fill": 2,
              "id": 43,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filesystem_avail_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - Available",
                  "metric": "",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "node_filesystem_free_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - Free",
                  "refId": "B",
                  "step": 2
                },
                {
                  "expr": "node_filesystem_size_bytes{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - Size",
                  "refId": "D",
                  "step": 2
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Filesystem space available",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 41,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filesystem_files_free{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - Free file nodes",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "File Nodes Free",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "File Nodes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 28,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filefd_maximum{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 4,
                  "legendFormat": "Max open files",
                  "refId": "A",
                  "step": 8
                },
                {
                  "expr": "node_filefd_allocated{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Open files",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "File Descriptor",
              "tooltip": {
                "shared": false,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Files",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 219,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filesystem_files{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - File nodes total",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "File Nodes Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "File Nodes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {
                "/ ReadOnly": "#890F02"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "id": 44,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 2,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_filesystem_readonly{instance=~\"$node:$port\",job=~\"$job\",device!~'rootfs'}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{mountpoint}} - ReadOnly",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Filesystem in ReadOnly",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Read Only",
                  "logBase": 1,
                  "max": "1",
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Filesystem Detail",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {
                "receive_packets_eth0": "#7EB26D",
                "receive_packets_lo": "#E24D42",
                "transmit_packets_eth0": "#7EB26D",
                "transmit_packets_lo": "#E24D42"
              },
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 60,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_packets_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_network_transmit_packets_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit",
                  "refId": "P",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic by Packets",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 142,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.errors.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.errors.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.errors.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.errors.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.errors.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.errors.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.errors.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_errs_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive errors",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_network_transmit_errs_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Rransmit errors",
                  "refId": "F",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 143,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.drop.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.drop.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.drop.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.drop.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.drop.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.drop.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.drop.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_drop_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive drop",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_network_transmit_drop_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit drop",
                  "refId": "H",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Drop",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 141,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.compressed.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.compressed.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.compressed.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.compressed.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.compressed.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.compressed.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.compressed.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_compressed_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive compressed",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_network_transmit_compressed_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit compressed",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Compressed",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 146,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.multicast.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.multicast.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.multicast.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.multicast.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.multicast.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.multicast.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.multicast.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_multicast_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive multicast",
                  "refId": "M",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Multicast",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 144,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.fifo.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.fifo.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.fifo.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.fifo.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.fifo.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.fifo.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.fifo.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_fifo_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive fifo",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_network_transmit_fifo_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit fifo",
                  "refId": "J",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Fifo",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 145,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.frame.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.frame.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.frame.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.frame.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*eth3.*.frame.*/",
                  "color": "#E24D42"
                },
                {
                  "alias": "/.*eth4.*.frame.*/",
                  "color": "#1F78C1"
                },
                {
                  "alias": "/.*eth5.*.frame.*/",
                  "color": "#BA43A9"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_receive_frame_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Receive frame",
                  "refId": "K",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Frame",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "pps",
                  "label": "Packets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 231,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.carrier.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.carrier.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.carrier.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.carrier.*/",
                  "color": "#EF843C"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_transmit_carrier_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Statistic transmit_carrier",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Carrier",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 232,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Trans.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*lo.*.carrier.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*eth0.*.carrier.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*eth1.*.carrier.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*eth2.*.carrier.*/",
                  "color": "#EF843C"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_network_transmit_colls_total{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{device}} - Transmit colls",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network Traffic Colls",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 61,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "NF conntrack limit",
                  "color": "#890F02",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_nf_conntrack_entries{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "NF conntrack entries",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "node_nf_conntrack_entries_limit{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "NF conntrack limit",
                  "refId": "P",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "NF Contrack",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Entries",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 230,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_arp_entries{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "{{ device }} - ARP entries",
                  "refId": "O",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ARP Entries",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Entries",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Traffic Detail",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 63,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_sockstat_TCP_alloc{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_alloc - Allocated sockets",
                  "refId": "D",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_TCP_inuse{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_inuse - Tcp sockets currently in use",
                  "refId": "E",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_TCP_mem{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_mem - Used memory for tcp",
                  "refId": "F",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_TCP_orphan{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_orphan - Orphan sockets",
                  "refId": "H",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_TCP_tw{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_tw - Sockets wating close",
                  "refId": "I",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Sockstat TCP",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Sockets",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 124,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_sockstat_UDPLITE_inuse{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "UDPLITE_inuse - Udplite sockets currently in use",
                  "refId": "J",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_UDP_inuse{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "UDP_inuse - Udp sockets currently in use",
                  "refId": "K",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_UDP_mem{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "UDP_mem - Used memory for udp",
                  "refId": "L",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Sockstat UDP",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Sockets",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 126,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_sockstat_sockets_used{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Sockets_used - Sockets currently in use",
                  "refId": "N",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Sockstat Used",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Sockets",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 220,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_sockstat_TCP_mem_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCP_mem_bytes - ",
                  "refId": "G",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_UDP_mem_bytes{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "UDP_mem_bytes - ",
                  "refId": "A",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Sockstat Memory Size",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": "Bytes",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "id": 125,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_sockstat_FRAG_inuse{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "FRAG_inuse - Frag sockets currently in use",
                  "refId": "A",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_FRAG_memory{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "FRAG_memory - Used memory for frag",
                  "refId": "B",
                  "step": 240
                },
                {
                  "expr": "node_sockstat_RAW_inuse{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RAW_inuse - Raw sockets currently in use",
                  "refId": "C",
                  "step": 240
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Sockstat FRAG / RAW",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Sockets",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Sockstat",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 49,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": null,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Discards.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*NoRoutes.*/",
                  "color": "#EAB839"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Ip_InReceives{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InReceives - IP inreceives",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_DefaultTTL{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 2,
                  "legendFormat": "DefaultTTL - Default TTL",
                  "refId": "B",
                  "step": 10
                },
                {
                  "expr": "irate(node_netstat_Ip_InDelivers{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InDelivers - IP indelivers",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_OutRequests{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutRequests - IP outrequests",
                  "refId": "P",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP In / Out",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 221,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Octets.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*McastPkts.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*McastOctets.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*BcastPkts.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*BcastOctets.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InOctets - Received octets",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_OutOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutOctets - Sent octets",
                  "refId": "Q",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP In / Out Octets",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Octects out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 119,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Octets.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*McastPkts.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*McastOctets.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*BcastPkts.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*BcastOctets.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InBcastPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InBcastPkts - Received IP broadcast datagrams",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_OutBcastPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutBcastPkts - Sent IP broadcast datagrams",
                  "refId": "N",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Bcast",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 222,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Octets.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*McastPkts.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*McastOctets.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*BcastPkts.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*BcastOctets.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InBcastOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InBcastOctets - Received IP broadcast octets",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_OutBcastOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutBcastOctets - Sent IP broadcast octects",
                  "refId": "M",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Bcast Octets",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Octets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 120,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Octets.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*McastPkts.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*McastOctets.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*BcastPkts.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*BcastOctets.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InMcastPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InMcastPkts - Received IP multicast datagrams",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_OutMcastPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutMcastPkts - Sent IP multicast datagrams",
                  "refId": "P",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Mcast",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 223,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Octets.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*McastPkts.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*McastOctets.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*BcastPkts.*/",
                  "color": "#EF843C"
                },
                {
                  "alias": "/.*BcastOctets.*/",
                  "color": "#E24D42"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InMcastOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InMcastOctets - Received IP multicast octets",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_OutMcastOctets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutMcastOctets - Sent IP multicast octets",
                  "refId": "O",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Mcast Octets",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Octets out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 81,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": null,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Ip_ForwDatagrams{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ForwDatagrams - IP outforwdatagrams",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_Forwarding{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "Forwarding - IP forwarding",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Forwarding",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 122,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": null,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Ip_FragCreates{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "FragCreates - IP fragmentation creations",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_FragFails{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "FragFails - IP fragmentation failures",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_FragOKs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "FragOKs - IP fragmentation oks",
                  "refId": "G",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Fragmented",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 51,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_IpExt_InCEPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InCEPkts - Congestion Experimented datagrams in",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InECT0Pkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InECT0Pkts - Datagrams received with ECT(0)",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InECT1Pkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InECT1Pkt - Datarams received with ECT(1)",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InNoECTPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InNoECTPkts - Datagrams received with NOECT",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP ECT / CEP",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 123,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": null,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Ip_ReasmFails{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ReasmFails - IP reassembly failures",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_ReasmOKs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ReasmOKs - IP reassembly oks",
                  "refId": "R",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_ReasmReqds{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ReasmReqds - IP reassembly requireds",
                  "refId": "S",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_ReasmTimeout{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ReasmTimeout - IP reasmtimeout",
                  "refId": "T",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Reasambled",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 118,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sideWidth": 300,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": null,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Discards.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*NoRoutes.*/",
                  "color": "#EAB839"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Ip_InDiscards{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InDiscards - IP indiscards",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_InHdrErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InHdrErrors - IP inhdrerrors",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_InUnknownProtos{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InUnknownProtos - IP inunknownprotos",
                  "refId": "M",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_OutDiscards{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutDiscards - IP outdiscards",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_OutNoRoutes{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutNoRoutes - IP outnoroutes",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InNoRoutes{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InNoRoutes - IP datagrams discarded due to no routes in forwarding path",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InCsumErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InCsumErrors - IP datagrams with checksum errors",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IpExt_InTruncatedPkts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InTruncatedPkts - IP datagrams discarded due to frame not carrying enough data",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Ip_InAddrErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InAddrErrors - IP inaddrerrors",
                  "refId": "D",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Netstat IP Errors / Discards",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Netstat",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 52,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": true,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*InSegs.*/",
                  "color": "#CCA300"
                },
                {
                  "alias": "/.*OutSegs.*/",
                  "color": "#CCA300"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Tcp_InCsumErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InCsumErrors - Segments received with checksum errors",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_InErrs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InErrs - Segments received in error (e.g., bad TCP checksums)",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_InSegs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InSegs - Segments received, including those received in error. This count includes segments received on currently established connections",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_OutRsts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutRsts - Segments sent containing the RST flag",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_OutSegs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutSegs - Segments sent, including those on current connections but excluding those containing only retransmitted octets",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_RetransSegs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RetransSegs - Segments retransmitted - that is, the number of TCP segments transmitted containing one or more previously transmitted octets",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Segments",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Segments out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 85,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*MaxConn *./",
                  "color": "#890F02",
                  "fill": 0
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_netstat_Tcp_CurrEstab{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "CurrEstab - TCP connections for which the current state is either ESTABLISHED or CLOSE- WAIT",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "node_netstat_Tcp_MaxConn{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "MaxConn - Limit on the total number of TCP connections the entity can support (Dinamic is \"-1\")",
                  "refId": "H",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Connections",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Connections",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 86,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_netstat_Tcp_RtoAlgorithm{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": true,
                  "intervalFactor": 2,
                  "legendFormat": "RtoAlgorithm - Algorithm used to determine the timeout value used for retransmitting unacknowledged octets",
                  "refId": "M",
                  "step": 4
                },
                {
                  "expr": "node_netstat_Tcp_RtoMax{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "RtoMax - Maximum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "node_netstat_Tcp_RtoMin{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "RtoMin - Minimum value permitted by a TCP implementation for the retransmission timeout, measured in milliseconds",
                  "refId": "O",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Retransmission",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "ms",
                  "label": "Milliseconds",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 82,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Tcp_ActiveOpens{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ActiveOpens - TCP connections that have made a direct transition to the SYN-SENT state from the CLOSED state",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_AttemptFails{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "AttemptFails - TCP connections that have made a direct transition to the CLOSED state from either the SYN-SENT and SYN-RCVD",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_EstabResets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "EstabResets - TCP connections that have made a direct transition to the CLOSED state from either the ESTABLISHED state or the CLOSE-WAIT state",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Tcp_PassiveOpens{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "PassiveOpens - TCP connections that have made a direct transition to the SYN-RCVD state from the LISTEN state",
                  "refId": "K",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Direct Transition",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Connections",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Netstat TCP",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 94,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortOnClose{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortOnClose - Connections aborted due to early user close",
                  "refId": "V",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortOnData{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortOnData - Connections aborted due to unexpected data",
                  "refId": "W",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortOnLinger{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortOnLinger - Connections aborted in lingered state after being closed",
                  "refId": "X",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortOnMemory{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortOnMemory - Connections aborted before attached to a socket",
                  "refId": "Y",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortOnTimeout{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortOnTimeout - Connections aborted due timeout",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAbortFailed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPAbortFailed - Connections aborted without send RST due insuffient memory",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPTimeouts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPTimeouts - Other TCP connections timeouts",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Aborts / Tiemouts",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Connections",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 92,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_DelayedACKLocked{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "DelayedACKLocked - Delayed acks further delayed because of locked socket",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_DelayedACKLost{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "DelayedACKLost - Times quick ack mode was activated",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_DelayedACKs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "DelayedACKs - Delayed acks sent",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Delayed ACK",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 91,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Sent.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "SyncookiesSent - SYN cookies sent",
                  "color": "#E0F9D7"
                },
                {
                  "alias": "SyncookiesRecv - SYN cookies received",
                  "color": "#E0F9D7"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_SyncookiesFailed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "SyncookiesFailed - Invalid SYN cookies received",
                  "refId": "R",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_SyncookiesRecv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "SyncookiesRecv - SYN cookies received",
                  "refId": "S",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_SyncookiesSent{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "SyncookiesSent - SYN cookies sent",
                  "refId": "T",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSYNChallenge{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SynChallenge - Challenge ACKs sent in response to SYN packets",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPChallengeACK{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "TCPChallengeACK - Challenge ACKs sent (RFC 5961 3.2)",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP SynCookie / Challenge",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 90,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPLossFailures{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPLossFailures - Timeouts in loss state",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPLossProbeRecovery{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPLossProbeRecovery - TCP loss probe recoveries",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPLossProbes{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPLossProbes - Sent TCP loss probes",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPLossUndo{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPLossUndo - Congestion windows recovered without slow start after partial ack",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPLostRetransmit{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPLostRetransmit - Retransmits lost",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP LOSS",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 53,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_ListenDrops{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ListenDrops - SYNs to LISTEN sockets ignored",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_LockDroppedIcmps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "LockDroppedIcmps - ICMP packets dropped because socket was locked",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDeferAcceptDrop{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPDeferAcceptDrop - Dropped ACK frames received by a socket in SYN_RECV state",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPBacklogDrop{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPBacklogDrop - Packets dropped bacause the socket's receive queue was full",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_OutOfWindowIcmps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutOfWindowIcmps - ICMP packets dropped because they were out-of-window",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPMinTTLDrop{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPMinTTLDrop - TCP packets dropped under minTTL condition",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP DROPS",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 101,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPForwardRetrans{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPForwardRetrans - Packets losts retransmitted with Forward RTO-Recovery",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSlowStartRetrans{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPSlowStartRetrans - Packets losts retransmitted after a slow start",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSynRetrans{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPSynRetrans - SYN-SYN/ACK retransmits to break down retransmissions in SYN, fast/timeout retransmits",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSpuriousRTOs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSpuriousRTOs - FRTO's successfully detected spurious RTOs",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSpuriousRtxHostQueues{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSpuriousRtxHostQueues - Times detected that the fast clone is not yet freed in tcp_transmit_skb()",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFullUndo{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPFullUndo - Retransmits that undid the CWND reduction",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRetransFail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPRetransFail - Failed tcp_retransmit_skb() calls",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPPartialUndo{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPPartialUndo - Congestion windows partially recovered using Hoe heuristic",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Retrans",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 87,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_PruneCalled{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "PruneCalled - Pkts pruned from recv queue because of soc buf overrun",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_RcvPruned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "RcvPruned - Packets pruned from receive queue",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_OfoPruned{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OfoPruned - Packets dropped from out-of-order queue because of socket buffer overrun",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Pruned",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 96,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDirectCopyFromBacklog{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPDirectCopyFromBacklog - Packets directly received from backlog",
                  "refId": "M",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDirectCopyFromPrequeue{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPDirectCopyFromPrequeue - Packets directly received from prequeue",
                  "refId": "N",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Direct Copy",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 100,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TW{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TW - TCP sockets finished time wait in fast timer",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TWKilled{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TWKilled - TCP sockets finished time wait in slow timer",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TWRecycled{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TWRecycled - Time wait sockets recycled by time stamp",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPTimeWaitOverflow{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPTimeWaitOverflow - Occurences of time wait bucket overflow",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP TimeWait",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 93,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_PAWSActive{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "PAWSActive - Active connections rejected because of time stamp",
                  "refId": "M",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_PAWSEstab{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "PAWSEstab - Pkts rejects in estab connections because of timestamp",
                  "refId": "N",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_PAWSPassive{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "PAWSPassive - Passive connections rejected because of time stamp",
                  "refId": "O",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP PAWS",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 98,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackRecovery{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackRecovery - Times recovered from packet loss by selective acknowledgements",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackRecoveryFail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackRecoveryFail - Issue while recovering packets lost using selective ACK",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackShiftFallback{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackShiftFallback - SACKs fallbacks",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackShifted{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackShifted - SACKs shifted",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSACKDiscard{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackDiscard -  Discarded due invalid SACK block.",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackFailures{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackFailures - Timeouts after SACK recovery",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSackMerged{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSackMerged - SACKs merged",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSACKReneging{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSACKReneging - Bad SACK blocks received",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSACKReorder{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSACKReorder - Times detected reordering using SACK",
                  "refId": "I",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP SACK",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 95,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKIgnoredOld{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKIgnoredOld - Discarded packets with duplicate SACK while retransmitting",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKOfoRecv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKOfoRecv - DSACKs for out of order packets received",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKOfoSent{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKOfoSent - DSACKs sent for out of order packets",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKOldSent{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKOldSent - DSACKs sent for old packets",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKRecv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKRecv - DSACKs received",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKUndo{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKUndo - Discarded packets with erroneous retransmit",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPDSACKIgnoredNoUndo{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPDSACKIgnoredNoUndo - Discarded packets with duplicate SACK",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP DSACK",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 97,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenActive{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenActive - Successful outbound TFO connections",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenActiveFail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenActiveFail - SYN-ACK packets received that did not acknowledge data sent in the SYN packet and caused a retransmissions without SYN data",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenCookieReqd{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenCookieReqd - Inbound SYN packets requesting TFO with TFO set but no cookie",
                  "refId": "R",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenListenOverflow{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenListenOverflow - Times the fastopen listen queue overflowed",
                  "refId": "S",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenPassive{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenPassive - Successful inbound TFO connections",
                  "refId": "T",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastOpenPassiveFail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastOpenPassiveFail - Inbound SYN packets with TFO cookie that was invalid",
                  "refId": "U",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFastRetrans{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPFastRetrans - Packets lost fast-retransmitted",
                  "refId": "V",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP FastOpen / FastRetrans",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 99,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPHPAcks{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPHPAcks - Acknowledgments not containing data received",
                  "refId": "Z",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPHPHits{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPHPHits - Packets header predicted",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPHPHitsToUser{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPHPHitsToUser - Packets header predicted and directly queued to user",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP HP",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 102,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPToZeroWindowAdv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPToZeroWindowAdv - Times window went from zero to non-zero",
                  "refId": "V",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPWantZeroWindowAdv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPWantZeroWindowAdv - Times zero window announced",
                  "refId": "W",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFromZeroWindowAdv{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPFromZeroWindowAdv - Times window went from zero to non-zero",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP ZeroWindow",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 103,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPFACKReorder{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPFACKReorder - Detected packets with re-ordering using FACK",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPTSReorder{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPTSReorder - Times detected packets with re-ordering using timestamp option",
                  "refId": "S",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Reorder",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 162,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRenoFailures{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPRenoFailures  - Timeouts after reno fast retransmit",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRenoRecovery{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPRenoRecovery - Times recovered from packet loss due to fast retransmit",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRenoRecoveryFail{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPRenoRecoveryFail - Times reno fast retransmits failed",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRenoReorder{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPRenoReorder - Times detected reordering using reno fast retransmit",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Reno",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 163,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPReqQFullDoCookies{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPReqQFullDoCookies - Times SYNCOOKIE was replied to client",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPReqQFullDrop{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPReqQFullDrop - Times SYN request was dropped due to disabled syncookies",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP ReqQ",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 164,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPOFODrop{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPOFODrop - Packets meant to be queued in OFO but dropped because socket rcvbuf limit reached",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPOFOMerge{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPOFOMerge - Packets in OFO that were merged with other packets",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPOFOQueue{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPOFOQueue - Packets queued in OFO queue",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Out of order",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 165,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPMD5NotFound{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPMD5NotFound - Times MD5 hash expected but not found",
                  "refId": "Z",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPMD5Unexpected{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPMD5Unexpected - Times MD5 hash unexpected but found",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP MD5",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 166,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPPrequeued{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPPrequeued - Packets directly queued to recvmsg prequeue",
                  "refId": "Z",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPPrequeueDropped{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPPrequeueDropped - Packets dropped from prequeue",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Prequeued",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "description": "",
              "fill": 2,
              "height": "",
              "id": 167,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRcvCoalesce{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPRcvCoalesce - Times tried to coalesce the receive queue",
                  "refId": "Z",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPRcvCollapsed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "TCPRcvCollapsed - Packets collapsed in receive queue due to low socket buffer",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Rcv",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 224,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPOrigDataSent{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPOrigDataSent - Outgoing packets with original data",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Original Data",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 225,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_ArpFilter{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ArpFilter - Arp packets filtered",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_IPReversePathFilter{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "IPReversePathFilter - Packets arrive from non directly connected network",
                  "refId": "G",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Filters",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 226,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPPureAcks{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPPureAcks - Acknowledgments not containing data payload received",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Pure ACK",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 227,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_TCPAutoCorking{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "TCPAutoCorking - Times stack detected skb was underused and its flush was deferred",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Auto Corking",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "height": "",
              "id": 104,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_TcpExt_BusyPollRxPackets{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "BusyPollRxPackets - Low latency application-fetched packets",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_EmbryonicRsts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "EmbryonicRsts - Resets received for embryonic SYN_RECV sockets",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_ListenOverflows{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "ListenOverflows - Times the listen queue of a socket overflowed",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPSchedulerFailed{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "TCPSchedulerFailed - Times receiver scheduled too late for direct processing",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_TcpExt_TCPMemoryPressures{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "intervalFactor": 2,
                  "legendFormat": "TCPMemoryPressures - TCP ran low on memory",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "TCP Issues",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": "0",
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Netstat TCP Linux MIPs",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 55,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Snd.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Datagrams.*/",
                  "color": "#EAB839"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Udp_InDatagrams{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InDatagrams - Datagrams received",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Udp_OutDatagrams{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutDatagrams - Datagrams sent",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "UDP In / Out",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 109,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Snd.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*bufErrors.*/",
                  "color": "#70DBED"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Udp_InCsumErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InCsumErrors - Datagrams with checksum errors",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Udp_InErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InErrors - Datagrams that could not be delivered to an application",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Udp_RcvbufErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RcvbufErrors - Datagrams for which not enough socket buffer memory to receive",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Udp_SndbufErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SndbufErrors - Datagrams for which not enough socket buffer memory to transmit",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Udp_NoPorts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "NoPorts - Datagrams received on a port with no listener",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "UDP Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 57,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Datagrams.*/",
                  "color": "#EAB839"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_UdpLite_InDatagrams{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InDatagrams - Packets received",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_UdpLite_OutDatagrams{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutDatagrams - Packets sent",
                  "refId": "E",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "UDP Lite In / Out",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "fill": 2,
              "height": "",
              "id": 110,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*bufErrors.*/",
                  "color": "#6ED0E0"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_UdpLite_InCsumErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InCsumErrors - Datagrams with checksum errors",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_UdpLite_InErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InErrors - Datagrams that could not be delivered to an application",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_UdpLite_RcvbufErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "RcvbufErrors - Datagrams for which not enough socket buffer memory to receive",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_UdpLite_SndbufErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "SndbufErrors - Datagrams for which not enough socket buffer memory to transmit",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_UdpLite_NoPorts{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "NoPorts - Datagrams received on a port with no listener",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "UDP Lite Errors",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Datagrams out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Netstat UDP",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 50,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Type3.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*SrcQuenchs.*/",
                  "color": "#705DA0"
                },
                {
                  "alias": "/.*ParmProb.*/",
                  "color": "#70DBED"
                },
                {
                  "alias": "/.*TimeExcds.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*DestUnreachs.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*InErrors.*/",
                  "color": "#890F02"
                },
                {
                  "alias": "/.*OutErrors.*/",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InErrors - Messages which the entity received but determined as having ICMP-specific errors (bad ICMP checksums, bad length, etc.)",
                  "refId": "I",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutErrors - Messages which this entity did not send due to problems discovered within ICMP, such as a lack of buffers",
                  "refId": "V",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InDestUnreachs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InDestUnreachs - Destination Unreachable messages received",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutDestUnreachs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutDestUnreachs - Destination Unreachable messages sent",
                  "refId": "B",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IcmpMsg_InType3{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InType3 - Destination unreachable",
                  "refId": "K",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IcmpMsg_OutType3{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutType3 - Destination unreachable",
                  "refId": "L",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_IcmpMsg_InType11{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InType11 - Time Exceeded",
                  "refId": "C",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP Errors 1",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 147,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Type3.*/",
                  "color": "#EAB839"
                },
                {
                  "alias": "/.*SrcQuenchs.*/",
                  "color": "#705DA0"
                },
                {
                  "alias": "/.*ParmProb.*/",
                  "color": "#70DBED"
                },
                {
                  "alias": "/.*TimeExcds.*/",
                  "color": "#EA6460"
                },
                {
                  "alias": "/.*DestUnreachs.*/",
                  "color": "#7EB26D"
                },
                {
                  "alias": "/.*InErrors.*/",
                  "color": "#890F02"
                },
                {
                  "alias": "/.*OutErrors.*/",
                  "color": "#890F02"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InCsumErrors{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InCsumErrors - Messages with ICMP checksum errors",
                  "refId": "E",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InTimeExcds{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InTimeExcds - Time Exceeded messages received",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutTimeExcds{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutTimeExcds - Time Exceeded messages sent",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InParmProbs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InParmProbs - Parameter Problem messages received",
                  "refId": "F",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutParmProbs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutParmProb - Parameter Problem messages sent",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InSrcQuenchs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "InSrcQuenchs - Source Quench messages received",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutSrcQuenchs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "OutSrcQuenchs - Source Quench messages sent",
                  "refId": "J",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP Errors 2",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 115,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*Msgs.*/",
                  "color": "#6ED0E0"
                },
                {
                  "alias": "/.*Redirects.*/",
                  "color": "#F9BA8F"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InMsgs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InMsgs -  Messages which the entity received. Note that this counter includes all those counted by icmpInErrors",
                  "refId": "J",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InRedirects{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InRedirects - Redirect messages received",
                  "refId": "L",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutMsgs{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutMsgs - Messages which this entity attempted to send. Note that this counter includes all those counted by icmpOutErrors",
                  "refId": "W",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutRedirects{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutRedirects -  Redirect messages sent. For a host, this object will always be zero, since hosts do not send redirects",
                  "refId": "Y",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP In / Out - Messages / Redirects",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 112,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*TimestampReps.*/",
                  "color": "#F9934E"
                },
                {
                  "alias": "/.*Timestamps -.*/",
                  "color": "#6ED0E0"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InTimestampReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InTimestampReps - Timestamp Reply messages received",
                  "refId": "O",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InTimestamps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InTimestamps - Timestamp (request) messages received",
                  "refId": "P",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutTimestampReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutTimestampReps - Timestamp Reply messages sent",
                  "refId": "A",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutTimestamps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutTimestamps - Timestamp (request) messages sent",
                  "refId": "B",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP Timestamps",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 114,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*EchoReps.*/",
                  "color": "#D683CE"
                },
                {
                  "alias": "/.*Echos -.*/",
                  "color": "#F9934E"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InEchoReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InEchoReps - Echo Reply messages received",
                  "refId": "G",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InEchos{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InEchos - Echo (request) messages received",
                  "refId": "H",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutEchoReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutEchoReps - Echo Reply messages sent",
                  "refId": "T",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutEchos{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutEchos - Echo (request) messages sent",
                  "refId": "U",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP Echos",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "decimals": null,
              "fill": 2,
              "height": "",
              "id": 113,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideZero": false,
                "max": true,
                "min": true,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "minSpan": 1,
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [
                {
                  "alias": "/.*Out.*/",
                  "transform": "negative-Y"
                },
                {
                  "alias": "/.*AddrMaskReps.*/",
                  "color": "#B7DBAB"
                },
                {
                  "alias": "/.*Masks -.*/",
                  "color": "#E5AC0E"
                }
              ],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "irate(node_netstat_Icmp_InAddrMaskReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InAddrMaskReps - Address Mask Reply messages received",
                  "refId": "C",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_InAddrMasks{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "InAddrMasks - Address Mask Request messages received",
                  "refId": "D",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutAddrMaskReps{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutAddrMaskReps - Address Mask Reply messages sent",
                  "refId": "Q",
                  "step": 4
                },
                {
                  "expr": "irate(node_netstat_Icmp_OutAddrMasks{instance=~\"$node:$port\",job=~\"$job\"}[5m])",
                  "format": "time_series",
                  "intervalFactor": 2,
                  "legendFormat": "OutAddrMasks - Address Mask Request messages sent",
                  "refId": "R",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "ICMP Masks",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Messages out (-) / in (+)",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Network Netstat ICMP",
          "titleSize": "h6"
        },
        {
          "collapse": true,
          "height": "375",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 40,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": true,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_scrape_collector_duration_seconds{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{collector}} - Scrape duration",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Node Exporter Scrape Time",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "s",
                  "label": "Seconds",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            },
            {
              "aliasColors": {},
              "bars": false,
              "dashLength": 10,
              "dashes": false,
              "datasource": "${DS_PROMETHEUS}",
              "description": "",
              "fill": 2,
              "id": 157,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": true,
                "min": true,
                "show": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 1,
              "links": [],
              "nullPointMode": "null",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "spaceLength": 10,
              "span": 6,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "node_scrape_collector_success{instance=~\"$node:$port\",job=~\"$job\"}",
                  "format": "time_series",
                  "hide": false,
                  "intervalFactor": 2,
                  "legendFormat": "{{collector}} - Scrape success",
                  "refId": "A",
                  "step": 4
                }
              ],
              "thresholds": [],
              "timeFrom": null,
              "timeShift": null,
              "title": "Node Exporter Scrape Success",
              "tooltip": {
                "shared": true,
                "sort": 0,
                "value_type": "individual"
              },
              "type": "graph",
              "xaxis": {
                "buckets": null,
                "mode": "time",
                "name": null,
                "show": true,
                "values": []
              },
              "yaxes": [
                {
                  "format": "short",
                  "label": "Counter",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "repeatIteration": null,
          "repeatRowId": null,
          "showTitle": false,
          "title": "Node Exporter",
          "titleSize": "h6"
        }
      ],
      "schemaVersion": 14,
      "style": "dark",
      "tags": [],
      "templating": {
        "list": [
          {
              "current": {
                  "text": "Prometheus",
                  "value": "Prometheus"
              },
              "hide": 0,
              "label": null,
              "name": "DS_PROMETHEUS",
              "options": [

              ],
              "query": "prometheus",
              "refresh": 1,
              "regex": "",
              "type": "datasource"
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "${DS_PROMETHEUS}",
            "hide": 0,
            "includeAll": false,
            "label": "Job",
            "multi": false,
            "name": "job",
            "options": [],
            "query": "label_values(node_uname_info, job)",
            "refresh": 1,
            "regex": "",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "${DS_PROMETHEUS}",
            "hide": 0,
            "includeAll": false,
            "label": "Host:",
            "multi": false,
            "name": "name",
            "options": [],
            "query": "label_values(node_uname_info{job=~\"$job\"}, nodename)",
            "refresh": 1,
            "regex": "",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "${DS_PROMETHEUS}",
            "hide": 2,
            "includeAll": false,
            "label": "Host:",
            "multi": false,
            "name": "node",
            "options": [],
            "query": "label_values(node_uname_info{nodename=\"$name\"}, instance)",
            "refresh": 1,
            "regex": "/([^:]+):.*/",
            "sort": 1,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          },
          {
            "allValue": null,
            "current": {},
            "datasource": "${DS_PROMETHEUS}",
            "hide": 0,
            "includeAll": false,
            "label": "Port",
            "multi": false,
            "name": "port",
            "options": [],
            "query": "label_values(node_uname_info{instance=~\"$node:(.*)\"}, instance)",
            "refresh": 1,
            "regex": "/[^:]+:(.*)/",
            "sort": 3,
            "tagValuesQuery": "",
            "tags": [],
            "tagsQuery": "",
            "type": "query",
            "useTags": false
          }
        ]
      },
      "time": {
        "from": "now-24h",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "timezone": "browser",
      "title": "Node Full",
      "version": 64
    }
kind: ConfigMap
metadata:
  name: grafana-dashboard-nodesfull
  namespace: monitoring
