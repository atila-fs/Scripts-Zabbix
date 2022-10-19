$s = w32tm /stripchart /computer:172.30.100.100 /samples:1 /dataonly
[regex]::match($s, '(\d{2}\.\d{7})').Groups[1].Value