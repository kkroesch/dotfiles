#
# Awk examples.
#

function reverse() {
    # Reverse IP address
    # Usage: echo <ip-address> | reverse
    awk -F'.' '{ printf("%d.%d.%d.%d", $4,$3,$2,$1) }'
}
