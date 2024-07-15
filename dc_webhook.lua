local http = require("socket.http")
local ltn12 = require("ltn12")
local cjson = require("cjson")
local url = require("socket.url")

-- MAKE SURE YOU HAVE THESE LIBRARIES INSTALLED

-- Replace this with your webhook URL
local webhook_url = "DISCORD WEBHOOK"

local payload = {
    content = "Sent by Inferno thru Lua", -- The content sent thru the webhook
    username = "Inferno's Lua webhook", -- The webhook sender name
    avatar_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUag614I0YMD4wVSePmmkedoRaHw6DsD9Gjg&s" -- The profile picture
}

local response_body = {}

local function handle_redirect(url)
    local res, code, response_headers = http.request {
        url = url,
        method = "POST",
        headers = {
            ["Content-Type"] = "application/json",
            ["Content-Length"] = tostring(#cjson.encode(payload))
        },
        source = ltn12.source.string(cjson.encode(payload)),
        sink = ltn12.sink.table(response_body)
    }
    return res, code, response_headers
end

local res, code, response_headers = handle_redirect(webhook_url)

if code == 301 then
    local new_url = response_headers["location"]
    if new_url then
        new_url = url.absolute(webhook_url, new_url)
        res, code, response_headers = handle_redirect(new_url)
    else
        print("Something broke.")
    end
end

-- InfernoTsugikuni on GitHub was here