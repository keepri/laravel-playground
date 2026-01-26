[www]
user = www-data
group = www-data
listen = 9000
; listen.owner = www-data
; listen.group = www-data
; listen.mode = 0660 ;claude says: The listen.mode = 0660 setting is meant for Unix socket files, not TCP ports. It's causing PHP-FPM to restrict access in a way that blocks nginx from connecting.

pm = dynamic
pm.max_children = 20
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
pm.max_requests = 500

; Log settings
access.log = /proc/self/fd/2
access.format = "[%t] %R - %m %r%Q%q | Status: %s | Duration: %{mili}dms | Memory: %{mega}MMB | CPU: %C%%"

; Environment variables
clear_env = no

; Security
security.limit_extensions = .php

; Performance tuning
request_slowlog_timeout = 30s
slowlog = /proc/self/fd/2
