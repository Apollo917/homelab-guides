$ORIGIN example.com.
$TTL  2d

@     IN    SOA   ns.example.com. admin.example.com. (
                  1000000000      ; Serial Note: increment after each change
                  12h             ; Refresh
                  15m             ; Retry
                  3w              ; Expire
                  2h )            ; Negative Cache TTL
@ IN  NS  ns.example.com.
@ IN  A   192.168.0.100

; ===== Name servers

ns  IN  A 192.168.0.100

; ===== Hosts

; = Devices

pc-one  IN  A 192.168.0.2

; = Homelab

node-1  IN  A   192.168.0.100

; ===== Prometheus Exporters

node-exporter.exporters.example.com.  IN  A  192.168.0.2     ; pc-one
node-exporter.exporters.example.com.  IN  A  192.168.0.100   ; node-1

; ===== Fallback

; Route all unresolved hostnames to this IP address
* IN  A 192.168.0.100
