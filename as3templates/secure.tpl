{
  "class": "AS3",
  "action": "deploy",
  "persist": true,
  "declaration": {
    "class": "ADC",
    "schemaVersion": "3.0.0",
    "id": "123abc",
    "label": "Sample 2",
    "remark": "HTTPS with predictive-node pool",
    "${TENANT}": {
      "class": "Tenant",
      "A1": {
        "class": "Application",
        "service": {
          "class": "Service_HTTPS",
          "virtualAddresses": [
             "${VIP_ADDRESS}"
          ],
          "pool": "web_pool",
          "serverTLS": "webtls"
        },
        "web_pool": {
          "class": "Pool",
          "loadBalancingMode": "predictive-node",
          "monitors": [
            "http"
          ],
          "members": [{
            "servicePort": 80,
            "shareNodes": true,
            "serverAddresses": [
               "192.168.86.54"
            ]
          }]
        },
        "webtls": {
          "class": "TLS_Server",
          "certificates": [{
            "certificate": "webcert"
          }]
        },
        "webcert": {
          "class": "Certificate",
          "remark": "in practice we recommend using a passphrase",
          "certificate": ${CERT},
          "privateKey": ${KEY},
          "chainCA": ${CA_CHAIN}
        }
      }
    }
  }
}