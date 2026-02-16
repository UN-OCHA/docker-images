-- If we are being accessed via https, no redirect is needed.
if ngx.var.http_x_forwarded_proto == "https" then
  return 0
end
-- If we are not accessed via https, and no exceptions are set, redirect.
if os.getenv("NGINX_OVERRIDE_PROTOCOL") == nil then
  return 1
end
-- Check the current hostname against the list of redirect exceptions.
-- If the hostname is listed or there is a global override, no redirect is needed.
-- Do not lowercase all listed exceptions, or the uppercase HTTP override will fail.
local http_host = ngx.var.http_host:lower()
for name in os.getenv("NGINX_OVERRIDE_PROTOCOL"):gmatch("[^,]+") do
  local name = name:gsub("\"", ""):gsub("%s+", "")
  if name:lower() == http_host or name == "HTTP" then
    return 0
  end
end
-- Redirect.
return 1
