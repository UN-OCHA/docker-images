-- Grab a lowercase version of the current hostname.
local http_host = ngx.var.http_host:lower()
-- If the current hostname is in the list of allowed hostnames, do not redirect.
for i = 1, #ngx.ctx.host_name_list do
  if ngx.ctx.host_name_list[i] == http_host then
    return 0
  end
end
-- The current hostname is not listed, redirect to the main hostname.
return 1
