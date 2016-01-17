-- utc date format helper
function utcdate(date)
	mydate = if date == nil then os.time() else date end
	return os.date('!%a, %d %b %Y %H:%M:%S GMT', mydate)
end

--[[ generate sharedkeylite
-- args = { account = 'account', 
--	key = 'accountkey', 
--	table = 'tablename'
--]]
function sharedkeylite(args)
	if (args.date == nil)
		args.date = mydate

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