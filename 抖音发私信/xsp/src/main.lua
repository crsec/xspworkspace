require("xxlib")
require("awz")

logs(frontAppName())
appbid = "com.ss.iphone.ugc.Aweme"

init(appbid, 0); --
toast("欢迎使用叉叉脚本！");
mSleep(1000) --延迟5秒

w,h = getScreenSize()
logs( w .." * ".. h )
if w == 750 and h == 1334 then
	require("iphone6")
end

function showbox(txt)
	box_key = box_key or 1
	if box_key == 1 then
		id = createHUD()     --创建一个HUD
		box_key = 2
	end
	if txt ~= nil then
		showHUD(id,"抖音->"..txt,14,"0xffff0000","0xffffffff",0,100,0,228,28)      --显示HUD内容
	else
		showHUD(id,"抖音->未识别",14,"0xffff0000","0xffffffff",0,100,0,228,28)      --显示HUD内容
	end
end

function commnet_count()
	local ocr, msg = createOCR({
		type = "tesseract", -- 指定tesseract引擎
		path = "[external]", -- 使用开发助手/叉叉助手的扩展字库
		lang = "eng_ext" -- 使用英文增强字库(注意需要提前下载好)
	})

	code, text = ocr:getText({
		psm  = 6,
		rect = { 636,846,743,896 },
		diff = {"0xffffff-0x101010"}, -- 时间颜色为纯黑
		whitelist = "0123456789w" -- 添加所有可能出现的字符作为白名单
	})
	if text then
		logs(text)
		local i,j = string.find(text,"w")
		if i~= nil and j ~= nil then
			return 10000
		else
			return tonumber(text)
		end
	end
end

--active(appbid)
--d("首页_微信")
--tab("微信tab",true,4,3)
function Dclick(x,y)
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
	local index = index or math.random(1,5)
	local times = times or 1000
	x = x+math.random(-2,2)
	y = y+math.random(-2,2)
	touchDown(index,x, y)
	mSleep(2500 + math.random(60,80))
	touchUp(index, x, y)
	mSleep(times)
end

function getadtext()
	local url = "http://idfa888.com/Public/dyid/?service=dyid.readtext"
	return getdy(url)
end


function follow()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local Up_key = false
	local Up_key_times = 0
	local lady_key = 0
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if success >= tonumber(resttable.data.mun) then
				dialog("关注完成")
				return true
			end
			if d('首页菜单_红绿')and tab("首页菜单",true,1)then
				delay(8)
				local commnet_mun = commnet_count() or 0
				if commnet_mun > 500 then
					showbox('评论'..commnet_mun)
					click(t['评论位置'][1],t['评论位置'][2])
				end
			elseif d('评论弹出界面')then
				showbox('评论弹出')
				if lady_key >= 5 then
					Up_key_times = 40
					lady_key = 0
				elseif Up_key_times >= 40 then
					if d('评论弹出界面_x',true)then
						Up_key_times = 0
					end
				else
					if Up_key then
						moveTo(340,750,340,750-160,5,20)
						Up_key = false
						Up_key_times = Up_key_times + 1
					elseif d('评论弹出界面_分割线')then
						local header = {x-47,y+50}
						click(header[1],header[2])
					end
				end
			elseif d('个人界面')then
				showbox('个人界面')

				if d('个人界面_女')then
					d('个人界面',true,1)
					Up_key = true
					lady_key = lady_key + 1
				elseif d('个人界面_发消息') or d('个人界面_已经关注')then
					Up_key = true
					success = success + 1
					showbox('关注次数->'..success)
					if d('个人界面',true,1)then
						delay(2)
					end
				elseif d('个人界面_男')then
					lady_key = 0
					d('个人界面_关注',true)
				else
					lady_key = 0
					showbox('性别无')
					if d('个人界面',true,1)then
						Up_key = true
						delay(2)
					end
				end
			else
				if d('弹窗取消')then
					click(t['back'][1],t['back'][2])
				else
					click(t['back'][1],t['back'][2])
				end
			end
		end
		delay(1)
	end
end


function send()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local Up_key = false
	local Up_key_times = 0
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if success >= tonumber(resttable.data.mun) then
				dialog("发送完成")
				return true
			end
			if d('首页菜单_红绿')and tab("首页菜单",true,3,4,90,"准备查看消息")then
				if d('消息界面')then
					if not(d('消息界面_粉丝',true))then
						click(t['顶部'][1],t['顶部'][2])
					else
						showbox('点击粉丝')
					end
				end
			elseif d('粉丝界面')then
				showbox('粉丝界面')
				if d('粉丝界面_关注',true)then
				elseif d('粉丝界面_暂时没有更多了')then
					if bottom_key >= 5 then
						dialog("已经到粉丝底部")
						return true
					else
						fensi = {83,263}
						click(fensi[1],fensi[2]+bottom_key*200)
						bottom_key = bottom_key + 1
					end
				else
					if Up_key then
						moveTo(340,750,340,750-200,10,20)
						Up_key = false
					elseif d('粉丝界面_相互关注')then
						click(x-555,y)
					end
				end
			elseif d('个人界面')then
				if d('个人界面_粉丝_发消息',true)then
				
				elseif d('个人界面_消息图标')then
					click(x-400,y)
					input(resttable.data.text..zfb[rd(1,#zfb)]..zfb[rd(1,#zfb)]..zfb[rd(1,#zfb)])
					if d('个人界面_发送',true)then
						delay(3)
						success = success + 1
						showbox('发送次数->'..success)
						send_key = true
						d('个人界面',true)
						d('个人界面',true)
						Up_key = true
					end
				elseif d('个人界面_消息图标灰')then
					click(x-400,y)
				else
					click(t['back'][1],t['back'][2])
				end
			else
				click(t['back'][1],t['back'][2])
			end
		end
		delay(1)
	end
end

function sendpic()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local Up_key = false
	local Up_key_times = 0
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if success >= tonumber(resttable.data.mun) then
				dialog("发送完成")
				return true
			end
			if d('首页菜单_红绿')and tab("首页菜单",true,3,4,90,"准备查看消息")then
				if d('消息界面')then
					if not(d('消息界面_粉丝',true))then
						click(t['顶部'][1],t['顶部'][2])
					else
						showbox('点击粉丝')
					end
				end
			elseif d('粉丝界面')then
				showbox('粉丝界面')
				if d('粉丝界面_关注',true)then
				elseif d('粉丝界面_暂时没有更多了')then
					if bottom_key >= 5 then
						dialog("已经到粉丝底部")
						return true
					else
						fensi = {83,263}
						click(fensi[1],fensi[2]+bottom_key*200)
						bottom_key = bottom_key + 1
					end
				else
					if Up_key then
						moveTo(340,750,340,750-200,10,20)
						Up_key = false
					elseif d('粉丝界面_相互关注')then
						click(x-555,y)
					end
				end
			elseif d('个人界面')then
				if d('个人界面_粉丝_发消息',true)then
				elseif d('个人界面_红_发送',true,1)then
					delay(5)
					Up_key = true
					success = success + 1
					send_key = true
					d('个人界面',true)
					d('个人界面',true)
				elseif d('个人界面_相册展开')then
					if d('个人界面_选择图片')then
						if x > 131 then
							click(x-33,y)
						else
							d('个人界面_相册展开',true,1)
						end
					end
				elseif d('个人界面_消息图标',true,1)then
					if d('个人界面_不能发送')then
						Up_key = true
						send_key = true
						d('个人界面',true)
						d('个人界面',true)
					end
				elseif d('个人界面_消息图标灰',true,1)then
				end
			
			else
				click(t['back'][1],t['back'][2])
			end
		end
		delay(1)
	end
end

function search()
	
	function play(sid)

		local TimeLine = mTime()
		local OutTimes = 60*5*1000
		


		while mTime()-TimeLine < OutTimes do
			if active(appbid,5)then
				if success >= alltodo then
					dialog("发送完成")
					return true
				end
				if d('首页菜单_红绿')and tab("首页菜单",true,1,4,90,"准备查看首页")then
					click(t['back'][1],t['back'][2])
				
				elseif d('搜索界面')then
					click(t['搜索界面_框框'][1],t['搜索界面_框框'][2])
					input("#CLEAR#")
				elseif d('搜索界面_取消红')then
					input(sid)
					if d('个人界面_发送',true)then
						delay(rd(4,6))
					else
						click(t['back'][1],t['back'][2])
					end
				elseif d('搜索界面_结果界面')then
					if d('搜索界面_结果_关注',true)then
						delay(2)
						click(t['back'][1],t['back'][2])
						local rdkey = rd(5,12)
						showbox('随机->'..rdkey)
						delay(rdkey)
						return true
					else
						click(t['back'][1],t['back'][2])
						return false
					end
					
				end
			end
			delay(1)
		end
	end
	
	local urlss = 'http://47.97.179.124:6789/aweme/api/users/get_follow?user_id=1'
	dyidlist = getdy(urlss)
	if dyidlist ~= nil then
		if tonumber(dyidlist.res) == 0 then
			for k,v in ipairs(dyidlist.message)do
				if v.gender == 1 then
					if play(v.short_id) then
						success = success + 1
						if success >= alltodo then
							dialog("关注完成")
							return true
						end
					end
				end
			end
		else
			dialog("取id失败,休息10秒",10)
		end
	end
	search()
end


local todo = getadtext()
alltodo = tonumber(todo.data.mun)
--logs('alltodo->'..alltodo)
--todo.data.doway = '3'

if todo ~= nil then
	if todo.data.doway == '1' then
		follow()
	elseif todo.data.doway == '2' then
		send()
	elseif todo.data.doway == '3' then
		sendpic()	
	elseif todo.data.doway == '4' then
		success = 0
		search()
	end
else
	dialog('网络连接失败,请重启动脚本')
end
mSleep(2000) --延迟5秒























































