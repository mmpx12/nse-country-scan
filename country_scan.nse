author = "Dr Claw"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery"}

description = [[
  Scan by country.
]]

local nmap = require "nmap"
local stdnse = require "stdnse"
local random_country = false
local country = stdnse.get_script_args("country_scan.country")
local max_ip = stdnse.get_script_args("country_scan.max_ip")

local function isempty(v)
  return v == nil or v == ''
end

if isempty(country) then
  local arr = {}
  local file = io.open("/usr/share/nmap/nselib/country/country_list.lst", "r")
  for line in file:lines() do
    table.insert(arr, line)
  end
  file:close()
  random_country = true
  country = arr[ math.random( #arr )]:sub(1,2)
end

local country_path = ("/usr/share/nmap/nselib/country/list/" .. country)

local file = io.open("/usr/share/nmap/nselib/country/country_list.lst", "r")

for line in file:lines() do
  if string.match(line, country) then
    country_name = line:sub(4, -1)
    break
  end
end

file:close()

prerule = function()
  print("\n ------------------")
  print("| NSE country scan |")
  print(" ------------------")
  if random_country == true then
    print("No args passed..")
    print("Scanning random country: " .. country_name)
  else
    print("Scanning: " .. country_name)
  end
  local i = 1
  print("\n")
  local file = io.open(country_path, "r")
  for ip in file:lines() do
    nmap.add_targets(ip)
    if i == tonumber(max_ip) then
      break
    else
      i = i + 1
    end
  end
  file:close()
end

action = function()
  return "ok"
end
