function slugify(str)
	if (str == nil) then
		return nil
	end
	return string.lower(string.gsub(string.gsub(str,"[^ A-Za-z]",""),"[ ]+","-"))
end

return { slugify = slugify }