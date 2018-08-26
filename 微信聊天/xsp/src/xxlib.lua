--日志打印
function logs(text,key)
	if key == "all" then
		sysLog(text)
		toast(text)
	elseif key == "toast" then
		toast(text)
	else
		sysLog(text)
	end
end

--点击基础函数
function click(x,y,times,index)
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
	local index = index or math.random(1,5)
	local times = times or 1000
	x = x+math.random(-2,2)
	y = y+math.random(-2,2)
	touchDown(index,x, y)
	mSleep(math.random(60,80))
	touchUp(index, x, y)
	mSleep(times)
end


--深度打印一个表
function print_r(t)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            logs(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        logs(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        logs(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        logs(indent.."["..pos..'] => "'..val..'"')
                    else
                        logs(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                logs(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        logs(tostring(t).." {")
        sub_print_r(t,"  ")
        logs("}")
    else
        sub_print_r(t,"  ")
    end
end


--多点比色
function 多点比色(name,clicks,clicks_mun,logtest)
	logs("即将多点比色")
	local ft = t[name]
	s = s or 90
	s = math.floor(0xff*(100-s)*0.01)
	for var = 1, #ft do
		local lr,lg,lb = getColorRGB(ft[var][1],ft[var][2])
		local rgb = ft[var][3]
		local r = math.floor(rgb/0x10000)
		local g = math.floor(rgb%0x10000/0x100)
		local b = math.floor(rgb%0x100)
		if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
			return false
		end
	end
	if clicks then
		local clicks_mun = clicks_mun or 1
		logs("多点比色点击->第 "..clicks_mun.." 点")
		click(ft[clicks_mun][1],ft[clicks_mun][2])
	end
	if logtest then
		logs(logtest)
	end
	logs("多点比色->成功("..name..")")
	return true
end

--多点找色
function 多点找色(name,clicks,clicks_mun,logtest)
	logs("即将多点找色->"..name)
	local ft = t[name]
	local clicks_mun = clicks_mun or 1
	if clicks_mun > #ft[2] then clicks_mun = #ft[2] end
	
	local x,y = findColor(ft[1],ft[2],ft[3],ft[4],ft[5],ft[6])
	if x > -1 and y > -1 then
		logs("多点找色成功->("..x..","..y..")")
		if clicks then
			local x1,y1 = x+ft[2][clicks_mun]["x"],y+ft[2][clicks_mun]["y"]
			logs("即将点击->第"..clicks_mun.."点->("..x1..","..y1..")")
			click(x1,y1)
		end
		if logtest then
			logs(logtest)
		end
		return true
	end
end

--2种找色合集
function d(name,clicks,clicks_mun,logtest)
	if #t[name][2] >= 4 then
		return 多点找色(name,clicks,clicks_mun,logtest)
	elseif #t[name][1] == 3 then
		return 多点比色(name,clicks,clicks_mun,logtest)
	end
end

--启动app
function active(appbid,times)
	local appid = frontAppName()
	if appbid == appid then
		return true
	else
		runApp(appbid)
		local times = times or 3.5
		mSleep(1000*times)
	end
end















































