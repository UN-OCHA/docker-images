if ngx.var.http_x_forwarded_proto == "https" then
  return 0
end
http_host = ngx.var.http_host:lower()
for name in os.getenv("NGINX_OVERRIDE_PROTOCOL"):gmatch("[^,]+") do
  name = name:gsub("\"", ""):gsub("%s+", ""):lower()
  if name == http_host or name == "HTTP" then
    return 0
  end
end
return 1
