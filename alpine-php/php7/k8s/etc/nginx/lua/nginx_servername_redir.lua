http_host = ngx.var.http_host:lower()
for i = 1, #ngx.ctx.host_name_list do
  if ngx.ctx.host_name_list[i] == http_host then
    return 0
  end
end
return 1
