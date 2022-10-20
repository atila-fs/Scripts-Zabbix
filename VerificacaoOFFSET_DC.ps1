$s = w32tm /stripchart /computer:IP do NTP /samples:1 /dataonly
[regex]::match($s, '(\d{2}\.\d{7})').Groups[1].Value
