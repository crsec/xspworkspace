require("xxlib")
init("com.tencent.xin", 0); --
toast("欢迎使用叉叉脚本！");
mSleep(1000) --延迟5秒

w,h = getScreenSize()
logs( w .." * ".. h )
if w == 640 and h == 1136 then
	require("iphone5s")
end


appbid = "com.tencent.xin"




--active(appbid)
--d("首页_微信")
--tab("微信tab",true,4,3)

function replay()
	local TimeLine = mTime()
	local OutTimes = 60*1*1000
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if d("首页_微信_有红点",true,1)then
				delay(rd(2,5))
			elseif d("微信_聊天_即将输入",false,1)then
				input("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）
				delay(1); 
				input(replay_txt[rd(1,#replay_txt)].."#ENTER#"); --在输入框中输入字符串"Welcome."并回车
				d("微信_聊天_空格",true,1)
				if d("微信_聊天_发送",true,1) then
					delay(rd(5,8))
					return true
				end
			elseif d("微信_聊天_输入",true,1) then
			end
		end
		delay(1)
    end
end

--发送消息
function send_message()
	local TimeLine = mTime()
	local OutTimes = 60*1*1000
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if d("微信_聊天_即将输入",false,1)then
				input("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）
				delay(1); 
				input(replay_txt[rd(1,#replay_txt)].."#ENTER#"); --在输入框中输入字符串"Welcome."并回车
				d("微信_聊天_空格",true,1)
				if d("微信_聊天_发送",true,1) then
					delay(rd(5,8))
					return true
				end
			elseif d("微信_聊天_输入",true,1) then
			elseif d("首页_微信_置顶发送",true,1)then
				delay(rd(2,5))
			end
		end
		delay(1)
    end
end

function 微信首页()
	if d("首页_微信") or tab("微信tab",true,1,4) then
		if d("微信tab_微信激活")then
			if d("微信tab_放大镜")then
				logs("初始化成功")
				return true
			else
				click(323,29)
			end
		end
	else
		d("微信back",true)
		d("微信_other_取消",true)
	end
end

function chat()
	local TimeLine = mTime()
	local OutTimes = 60*5*1000
	local relpay_key = true
	local send_key = true
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if 微信首页()then
				if send_key and send_message() then
					send_key = false
				elseif relpay_key and d("首页_微信_有红点",false,1) then
					replay()
				end
			end
		end
		delay(1)
    end
end





--%H	24小时制中的小时数
--%M	分钟数
current_time = os.date("%Y-%m-%d-%H");

logs(current_time)
while true do
	local Hour = tonumber(os.date("%H"))
	local workTime = mTime()
	
	if Hour >= 8 and Hour < 20 then
		--delay(rd(1,10)*60+rd(1,50))
		chat()
		closeX(appbid)
		delay(rd(15,20)*60+rd(1,60))
	end
end









mSleep(2000) --延迟5秒























































