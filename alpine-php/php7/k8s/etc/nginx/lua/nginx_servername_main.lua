ngx.ctx.host_name_list = {}
for name in os.getenv("NGINX_SERVERNAME"):gmatch("[%S]+") do
  name = name:lower()
  table.insert(ngx.ctx.host_name_list, name)
end
return ngx.ctx.host_name_list[1]
