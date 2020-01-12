if ngx.var.http_x_forwarded_proto == "https" then
  return 0
end
ngx.ctx.override_protocol_redirect = os.getenv("NGINX_OVERRIDE_PROTOCOL")
if ngx.ctx.override_protocol_redirect == "HTTP" then
  return 0
end
return 1
