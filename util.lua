function trim(str)
	if (str == nil) then
		return nil
	end
	return str:match('^%s*(.*%S)') or ''
end

function slugify(str)
	if (str == nil) then
		return nil
	end
	str = trim(str)
	return string.lower(string.gsub(string.gsub(str,"[^ A-Za-z]"," "),"[ ]+","-"))
end

function slugemail(str)
	if (str == nil) then
		return nil
	end
	str = trim(str)
	return string.lower(string.gsub(str,"[^@0-9A-Za-z]","-"))
end

return { 
	slugify = slugify, 
	trim = trim,
	slugemail = slugemail 
}