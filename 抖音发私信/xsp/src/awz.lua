awzbid = 'AWZ'
require("xxlib")

function activeawz(appbid,times)
	local appid = frontAppName()
	if appbid == appid then
		return true
	else
		runApp(appbid)
		local times = times or 3.5
		mSleep(1000*times)
	end
end


function awzUrl(newUrl)
local bb = require("badboy")
	bb.loadluasocket()
	local http = bb.http
	local res, code = http.request(newUrl);
	if code == 200 then
		logs(res)
		--//{"result":1}
		local json = bb.getJSON()
		local tabless = json.decode(res)
		if tabless["result"] == 1 then
			return true
		end
	end
end

function awz_next()
	out_time = mTime()/1000
	while mTime()/1000-out_time <= 15 do
		if activeawz(awzbid,2)then
			local url = "http://127.0.0.1:1688/cmd?fun=nextrecord"
			return awzUrl(url)
		end
		mSleep(1000* 2)
	end
end

