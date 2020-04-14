-- Initialise a new internal variable for the defined hostnames.
ngx.ctx.host_name_list = {}
-- Loop through the environment variable and make a list of allowed hostnames.
for name in os.getenv("NGINX_SERVERNAME"):gmatch("[^,]+") do
  name = name:gsub("\"", ""):gsub("%s+", ""):lower()
  table.insert(ngx.ctx.host_name_list, name)
end
-- Return the first (= main) defined hostname.
return ngx.ctx.host_name_list[1]
