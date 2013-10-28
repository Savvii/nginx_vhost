Description
===========
Renders and enables vhost files for nginx.

This was written because at the time there was no other simple way to render
out a vhost file for nginx that proxies to unicorn locally over a unix socket

## data_bag.rb
Lets you configure multiple vhost files from data bags.

## default.rb
Does nothing

Requirements
============
## Suggests
nginx

Isn't required, but I'm not sure why else you would need nginx config files.

## Tested on:

Ubuntu 10.04, 12.04
Centos 5.8, 6.3

Should work everywhere

Attributes
==========

## data_bag.rb
```
node.nginx.vhosts = []
node.nginx.vhost.data_bag_name = "nginx"
```

### SSL
Define both @ssl_cert and @ssl_key to get SSL support. Defining both,
with:

```json
{
 "ssl_certificate": "/etc/nginx/ssl/savviihq.com/2013/savviihq.com.crt;",
 "ssl_certificate_key?": "/etc/nginx/ssl/savviihq.com/2013/private.key;"
}
```

results in e.g.:

```
  ssl on;
  ssl_certificate     /etc/nginx/ssl/savviihq.com/2013/savviihq.com.crt;
  ssl_certificate_key /etc/nginx/ssl/savviihq.com/2013/private.key;
  ssl_protocols TLSv1.2 TLSv1.1 TLSv1 SSLv3;
  ssl_ciphers ECDHE-RSA-AES256-SHA384:AES256-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM;
  ssl_prefer_server_ciphers on;
```

And an additional:
```
  listen 334 ssl;
```

NOTE: the recipe does not check wether the certificate exists, is valid
or any other check on the certificate.

Usage
=====

## simple unicorn upstream
```
nginx_vhost "unicorn.example.com" do
  sockets [ "unix:/path/to/unicorn.sock" ]
end
```

## static ssl
```
nginx_vhost "ssl.example.com" do
  port 443
  ssl_key  "/path/to/cert.key"
  ssl_cert "/path/to/cert.pem"
  upstream false
end
```

## simple remote upstreams

```
nginx_vhost "example.com" do
  servers [ "10.0.0.1:80", "10.0.0.2:80", "10.0.0.3:80" ]
end
```

