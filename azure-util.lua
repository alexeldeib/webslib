-- utc date format helper
function utcdate(date)
	local mydate = date
	if (date == nil) then 
		myDate = os.time()
	end
	return os.date('!%a, %d %b %Y %H:%M:%S GMT', mydate)
end

--[[ generate sharedkeylite
-- args = { account = 'account', 
--	key = 'accountkey', 
--	table = 'tablename'
--]]
function sharedkeylite(args)
	if (args.date == nil) then
		args.date = mydate
	end
	
	local sts = string.format("%s\n/%s/%s", args.date, args.account, args.table)
	local sig = base64.encode(
		crypto.hmac(base64.decode(args.key), sts, crypto.sha256).digest())

	return {
		signature = sign,
		date = date
	}
end

return {
	utcdate = utcdate,
	sharedkeylite = sharedkeylite
}