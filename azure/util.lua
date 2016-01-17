-- utc date format helper
function utcdate(date)
	local mydate = date
	if (date == nil) then 
		mydate = os.time()
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
		args.date = utcdate()
	end
	
	local sts = string.format("%s\n/%s/%s", args.date, args.account, args.table)
	-- log(sts)
	args.sig = base64.encode(
		crypto.hmac(base64.decode(args.key), sts, crypto.sha256).digest())

	return args
end

return {
	utcdate = utcdate,
	sharedkeylite = sharedkeylite
}