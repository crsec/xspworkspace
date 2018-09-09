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

function replay()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			if d("抖音_私信回复",true,1)then
			elseif d("抖音_私信发送") or d("抖音_私信发送_灰",true,1) then
				input(replay_txt[rd(1,#replay_txt)])
				d("抖音_私信发送",true,1)
				moveTo(389,1136,389,800)
			elseif d("抖音_点击信息",true,1)then
			end
		end
		delay(1)
    end
end

function getadtext()
	local url = "http://idfa888.com/Public/dyid/?service=dyid.readtext"
	return getdy(url)
end


function seach_follow_send()
	local TimeLine = mTime()
	local OutTimes = 60*10*1000
	local success = 0
	local resttable = getadtext()
	local last = false
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			
			logs('success->|'..success)
			
			if success <= tonumber(resttable['data']['mun']) then
				if d("抖音主界面")and tab("首页tab",true,1,5)then
					t['抖音主界面'].tap()
				elseif d("抖音搜索界面")then
					Dclick(t["抖音搜索界面_点搜索框"][1],t["抖音搜索界面_点搜索框"][2])
					
--					input("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）

					if success == tonumber(resttable['data']['mun']) then
						writePasteboard(resttable['data']['dyid'])
--						input(resttable['data']['dyid'])
						last = true
					else
						url = "http://idfa888.com/Public/dyid/?service=dyid.getid"
						local info = getdy(url)
						writePasteboard(info["data"]["dyid"])
--						input(info["data"]["dyid"]); --在输入框中输入字符串"Welcome."并回车
						
						logs(info["data"]["dyid"],"all")
						delay(1)
					end
					
					if d("抖音搜索界面_粘贴",true)then
						if d("抖音搜索界面_搜索按钮",true)then
							delay(rd(3,5))
						end
					end
					
				else
						
					if d("抖音用户界面")then
						if d("抖音用户界面_+关注",true,1)then
						elseif d("抖音用户界面_发消息") or d('抖音用户界面_发消息_灰')then
							t["抖音用户界面_发消息"].tap()
						elseif d("消息界面_发过消息")then
							if last then
								if d("抖音用户界面_发消息_位置")then
									Dclick(x-400,y)
									writePasteboard(resttable['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
		--							input(getadtext()['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
									if d("抖音用户界面_发消息粘贴",true)then
										if d("抖音搜索界面_搜索按钮",true)then
											success = success + 1
											delay(rd(3,5))
										end
									end
								end
							else
								t['消息界面_发过消息'].tap()
								t['消息界面_发过消息'].tap()
								t['消息界面_发过消息'].tap()
							end
						else
							if d("抖音用户界面_发消息_位置")then
								Dclick(x-400,y)
								writePasteboard(resttable['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
	--							input(getadtext()['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
								if d("抖音用户界面_发消息粘贴",true)then
									if d("抖音搜索界面_搜索按钮",true)then
										success = success + 1
										delay(rd(3,5))
									end
								end
							end
						end
					elseif d('搜索结果界面')then
						logs('--')
						if d('抖音搜索界面_搜索关注按钮') or d('抖音搜索界面_搜索_已关注按钮')then
							t['抖音搜索界面_搜索关注按钮'].tap()
						else
							t['抖音搜索界面_搜索关注按钮'].tap()
						end
					else
						if d("qq登录按钮",true,1)then
							delay(rd(8,10))
							if d("qq登录按钮_登录",true,1)then
								delay(rd(8,10))
							end
						elseif d("绑定手机跳过",true,1)then
						else
							logs("otehr")
							t['消息界面_发过消息'].tap()
						end
					end
				end
			else
				return true
			end
		end
		delay(1)
    end
end

function seach_follow()
	local TimeLine = mTime()
	local OutTimes = 60*10*1000
	local success = 0
	local resttable = getadtext()
	local last = false
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			
			logs('success->|'..success)
			
			if success <= tonumber(resttable['data']['mun']) then
				if d("抖音主界面")and tab("首页tab",true,1,6)then
					t['抖音主界面'].tap()
				elseif d("抖音搜索界面")then
					Dclick(t["抖音搜索界面_点搜索框"][1],t["抖音搜索界面_点搜索框"][2])
					
--					input("#CLEAR#") --删除输入框中的文字（假设输入框中已存在文字）

					if success == tonumber(resttable['data']['mun']) then
						writePasteboard(resttable['data']['dyid'])
--						input(resttable['data']['dyid'])
						last = true
					else
						url = "http://idfa888.com/Public/dyid/?service=dyid.getid"
						local info = getdy(url)
						writePasteboard(info["data"]["dyid"])
--						input(info["data"]["dyid"]); --在输入框中输入字符串"Welcome."并回车
						
						logs(info["data"]["dyid"],"all")
						delay(1)
					end
					
					if d("抖音搜索界面_粘贴",true)then
						if d("抖音搜索界面_搜索按钮",true)then
							delay(rd(3,5))
						end
					end
					
				else
						
					if d("抖音用户界面")then
						t['消息界面_发过消息'].tap()
					elseif d('搜索结果界面')then
						if d('抖音搜索界面_搜索关注按钮',true,1) then
						elseif d('抖音搜索界面_搜索_已关注按钮')then
							success = success + 1
							t['消息界面_发过消息'].tap()
						else
							t['消息界面_发过消息'].tap()
						end
					else
						if d("qq登录按钮",true,1)then
							delay(rd(8,10))
							if d("qq登录按钮_登录",true,1)then
								delay(rd(8,10))
							end
						elseif d("绑定手机跳过",true,1)then
						else
							logs("otehr")
							t['消息界面_发过消息'].tap()
						end
					end
				end
			else
				return true
			end
		end
		delay(1)
    end
end

function send_follow_one()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local last = false
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			
			logs('success->|'..success)
			
			if success <= tonumber(resttable['data']['mun']) then
				if  d("抖音主界面") and tab("首页tab",true,3,6)then
					if d("消息界面_粉丝",1,1)then
						delay(2)
					end
					
				elseif d("粉丝界面")then
					if d("粉丝界面_关注",true,1)then
						
					elseif d('粉丝界面_暂时没有更多了')then
						if bottom_key >= 5 then
							return true
						else
							fensi = {83,263}
							click(fensi[1],fensi[2]+bottom_key*200)
							bottom_key = bottom_key + 1
						end	
						
					elseif last then
						moveTo(366,800,366,800-210,2,20)
						delay(1)
						last = false
					elseif d("粉丝界面_相互关注")then
						click(x-560,y)
						last = true
					end
					
				else
					if d("抖音用户界面")then
						if send_key then
							t['消息界面_发过消息'].tap()
							t['消息界面_发过消息'].tap()
							send_key = false
						elseif d("抖音用户界面_+关注",true,1)then
						elseif d("抖音用户界面_发消息") or d('抖音用户界面_发消息_灰')then
							t["抖音用户界面_发消息"].tap()
						elseif d("消息界面_发过消息")then
							t['消息界面_发过消息'].tap()
							t['消息界面_发过消息'].tap()
							last = true
						else
							if d("抖音用户界面_发消息_位置")then
								Dclick(x-400,y)
								writePasteboard(resttable['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
	--							input(getadtext()['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
								if d("抖音用户界面_发消息粘贴",true)then
									if d("抖音搜索界面_搜索按钮",true)then
										last = true
										success = success + 1
										delay(rd(3,5))
										t['消息界面_发过消息'].tap()
										t['消息界面_发过消息'].tap()
									end
								end
							end

						--[[
							if d("抖音用户界面_发消息_位置",true,1)then
								if d("消息发送_失败")then
									last = true
									send_key = true
								end
							elseif d("消息界面_相册")then
								t["消息界面_相册"].tap()
								delay(1)
								if d("图片_发送",true,1) then
									send_key = true
								end
							else
								t['消息界面_发过消息'].tap()
							end
						--]]
						end
					else
						if d("qq登录按钮",true,1)then
							delay(rd(8,10))
							if d("qq登录按钮_登录",true,1)then
								delay(rd(8,10))
							end
						elseif d("绑定手机跳过",true,1)then
						elseif d("图片_发送",true,1)then
							send_key = true
						else
							if d("抖音搜索界面")then
								t['抖音搜索界面'].tap()
							else
								logs("otehr")
								t['消息界面_发过消息'].tap()
							end
						end
					end
					
				end
			else
				return true
			end
		end
		delay(1)
    end
end


function send_follow_all()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local last = false
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			
			logs('success->|'..success)
			
			if success <= tonumber(resttable['data']['mun']) then
				if  d("抖音主界面") and tab("首页tab",true,3,6)then
					if d("消息界面_粉丝",1,1)then
						delay(2)
					end
					
				elseif d("粉丝界面")then
					if d("粉丝界面_关注",true,1)then
						
					elseif d('粉丝界面_暂时没有更多了')then
						if bottom_key >= 5 then
							return true
						else
							fensi = {83,263}
							click(fensi[1],fensi[2]+bottom_key*200)
							bottom_key = bottom_key + 1
						end	
						
					elseif last then
						moveTo(366,800,366,800-210,2,20)
						delay(1)
						last = false
					elseif d("粉丝界面_相互关注")then
						click(x-560,y)
						last = true
					end
					
				else
					if d("抖音用户界面")then
						if send_key then
							t['消息界面_发过消息'].tap()
							t['消息界面_发过消息'].tap()
							send_key = false
						elseif d("抖音用户界面_+关注",true,1)then
						elseif d("抖音用户界面_发消息") or d('抖音用户界面_发消息_灰')then
							t["抖音用户界面_发消息"].tap()
						else
							if d("抖音用户界面_发消息_位置")then
								Dclick(x-400,y)
								writePasteboard(resttable['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
	--							input(getadtext()['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
								if d("抖音用户界面_发消息粘贴",true)then
									if d("抖音搜索界面_搜索按钮",true)then
										last = true
										success = success + 1
										delay(rd(3,5))
										t['消息界面_发过消息'].tap()
										t['消息界面_发过消息'].tap()
									end
								end
							end

						--[[
							if d("抖音用户界面_发消息_位置",true,1)then
								if d("消息发送_失败")then
									last = true
									send_key = true
								end
							elseif d("消息界面_相册")then
								t["消息界面_相册"].tap()
								delay(1)
								if d("图片_发送",true,1) then
									send_key = true
								end
							else
								t['消息界面_发过消息'].tap()
							end
						--]]
						end
					else
						if d("qq登录按钮",true,1)then
							delay(rd(8,10))
							if d("qq登录按钮_登录",true,1)then
								delay(rd(8,10))
							end
						elseif d("绑定手机跳过",true,1)then
						elseif d("图片_发送",true,1)then
							send_key = true
						else
							if d("抖音搜索界面")then
								t['抖音搜索界面'].tap()
							else
								logs("otehr")
								t['消息界面_发过消息'].tap()
							end
						end
					end
					
				end
			else
				return true
			end
		end
		delay(1)
    end
end

---

function commnet_follow()
	local TimeLine = mTime()
	local OutTimes = 60*30*1000
	local success = 0
	local resttable = getadtext()
	local last = false
	local send_key = false
	local bottom_key = 0
	print_r(resttable)
	
	while mTime()-TimeLine < OutTimes do
		if active(appbid,5)then
			
			logs('success->|'..success)
			
			if success <= tonumber(resttable['data']['mun']) then
				if  d("抖音主界面") and tab("首页tab",true,3,6)then
					if d("消息界面_粉丝",1,1)then
						delay(2)
					end
					
				elseif d("粉丝界面")then
					if d("粉丝界面_关注",true,1)then
						
					elseif d('粉丝界面_暂时没有更多了')then
						if bottom_key >= 5 then
							return true
						else
							fensi = {83,263}
							click(fensi[1],fensi[2]+bottom_key*200)
							bottom_key = bottom_key + 1
						end	
						
					elseif last then
						moveTo(366,800,366,800-210,2,20)
						delay(1)
						last = false
					elseif d("粉丝界面_相互关注")then
						click(x-560,y)
						last = true
					end
					
				else
					if d("抖音用户界面")then
						if send_key then
							t['消息界面_发过消息'].tap()
							t['消息界面_发过消息'].tap()
							send_key = false
						elseif d("抖音用户界面_+关注",true,1)then
						elseif d("抖音用户界面_发消息") or d('抖音用户界面_发消息_灰')then
							t["抖音用户界面_发消息"].tap()
						else
							if d("抖音用户界面_发消息_位置")then
								Dclick(x-400,y)
								writePasteboard(resttable['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
	--							input(getadtext()['data']['text']..zfb[rd(1,#zfb)]..","..zfb[rd(1,#zfb)])
								if d("抖音用户界面_发消息粘贴",true)then
									if d("抖音搜索界面_搜索按钮",true)then
										last = true
										success = success + 1
										delay(rd(3,5))
										t['消息界面_发过消息'].tap()
										t['消息界面_发过消息'].tap()
									end
								end
							end

						--[[
							if d("抖音用户界面_发消息_位置",true,1)then
								if d("消息发送_失败")then
									last = true
									send_key = true
								end
							elseif d("消息界面_相册")then
								t["消息界面_相册"].tap()
								delay(1)
								if d("图片_发送",true,1) then
									send_key = true
								end
							else
								t['消息界面_发过消息'].tap()
							end
						--]]
						end
					else
						if d("qq登录按钮",true,1)then
							delay(rd(8,10))
							if d("qq登录按钮_登录",true,1)then
								delay(rd(8,10))
							end
						elseif d("绑定手机跳过",true,1)then
						elseif d("图片_发送",true,1)then
							send_key = true
						else
							if d("抖音搜索界面")then
								t['抖音搜索界面'].tap()
							else
								logs("otehr")
								t['消息界面_发过消息'].tap()
							end
						end
					end
					
				end
			else
				return true
			end
		end
		delay(1)
    end
end


--[[
local lun_index = 0
while 1 do
	local resttable = getadtext()
	if lun_index >= tonumber(resttable['data']['lun']) then
		dialog("完成任务")
		return true
	end
	
	if resttable['data']['doway'] == "1" then
		seach_follow()
	elseif resttable['data']['doway'] == "2" then
		seach_follow_send()
	elseif resttable['data']['doway'] == "3" then
		send_follow_one()
	elseif resttable['data']['doway'] == "4" then
		send_follow_all()
	end
	awz_next()
	lun_index = lun_index + 1
	logs("完成一轮","all")
	delay(1)
	
end
--]]

local ocr, msg = createOCR({
    type = "tesseract", -- 指定tesseract引擎
    path = "[external]", -- 使用开发助手/叉叉助手的扩展字库
    lang = "chi_sim" -- 使用英文增强字库(注意需要提前下载好)
})

    code, text = ocr:getText({
        rect = { 76,575,296,634 },
        diff = {"0x5b5b5b-0x202020"}, -- 时间颜色为纯黑
--        whitelist = "T0123456789" -- 添加所有可能出现的字符作为白名单
    })

logs(text)


mSleep(2000) --延迟5秒























































