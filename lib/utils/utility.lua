local component = require("component")

local utility = {}

function utility.machine(address)
    local proxy = component.get(address)
    if(proxy ~= nil) then
        return component.proxy(proxy)
    else
        return nil
    end
end
function utility.RGB(hex)
    local r = ((hex >> 16) & 0xFF) / 255.0
    local g = ((hex >> 8) & 0xFF) / 255.0
    local b = ((hex) & 0xFF) / 255.0
    return r, g, b
end
--Small = 1, Normal = 2, Large = 3, Auto = 4x to 10x (Even)
function utility.screensize(resolution, scale)
    scale = scale or 3
    return {resolution[1]/scale, resolution[2]/scale}
end
--Returns given number formatted as XXX,XXX,XXX
function utility.splitNumber(number)
    local formattedNumber = {}
    local string = tostring(math.abs(number))
    local sign = number/math.abs(number)
    for i = 1, #string do
      n = string:sub(i, i)
      formattedNumber[i] = n
      if ((#string-i) % 3 == 0) and (#string-i > 0) then
        formattedNumber[i] = formattedNumber[i] .. ","
      end
    end
    if(sign < 0) then table.insert(formattedNumber, 1, "-") end
    return table.concat(formattedNumber, "")
end
--Returns a given number in seconds formatted as Hours Minutes Seconds
function utility.time(number)
    if number == 0 then return 0 else
        local hours =  math.floor(number/3600)
        local minutes = math.floor((number - math.floor(number/3600)*3600)/60)
        local seconds = (number%60)
        if hours > 17000 then
            local years = math.floor(hours/(24*365))
            local days = math.floor((hours - (years * 24 * 365)) / 24)
            return (years.." Years "..days.." Days")
        elseif hours > 48 then
            local days = math.floor(hours/24)
            hours = math.floor(hours-days*24)
            return (days.."d "..hours.."h "..minutes.."m")
        else
            return (hours.."h "..minutes.."m "..seconds.."s")
        end
    end
end

function utility.percentage(number)
    return (math.floor(number*1000)/10).."%"
end

return utility