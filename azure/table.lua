local util = require('azure.util')
--[[
  p
   .account      azure account
   .key          account key
   .table        azure table
]]

-- list items
function list(p, query)
	local skl = util.sharedkeylite({
		account = p.account, 
		key = p.key, 
		table = p.table })

	local url = string.format("https://%s.table.core.windows.net/%s", p.account, p.table)
	local auth = string.format('SharedKeyLite %s:%s', p.account, skl.signature)

	if (query.filter) then
		queryString = string.format('%s&$filter=%s', queryString, query.filter)
	end

	if (query.top) then
		queryString = string.format('%s&$top=%s', queryString, query.top)
	end

	if (query.select) then
		queryString = string.format('%s&$select=%s', queryString, query.select)
	end

	local fullPath = string.format("%s?%s", url, string.gsub(str, "^\&+", ""))
	local response = http.request {
		method = 'GET',
		url = fullPath,
		headers = { 
			["Authorization"] = auth,
			["x-ms-date"] = skl.date,
			["Accept"] = "application/json;odata=nometadata",
			["x-ms-version"] = "2014-02-14"
		}
	}
    return response
end

-- create an item
function create(p, item)
	local skl = util.sharedkeylite({
		account = p.account, 
		key = p.key, 
		table = p.table })
	
	local url = string.format("https://%s.table.core.windows.net/%s", p.account, p.table)
	local auth = string.format('SharedKeyLite %s:%s', p.account, skl.signature)

	local response = http.request {
		method = 'POST',
		url = url,
		data = json.stringify(item),
		headers = { 
			["Authorization"] = auth,
			["x-ms-date"] = skl.date,
			["Accept"] = "application/json;odata=nometadata",
			["x-ms-version"] = "2014-02-14",
			["Content-Type"] = "application/json"
		}
	}

	return response
end

-- update an item
function update(p, item)
	local myTable = string.format("%s(PartitionKey='%s',RowKey='%s')", p.table, item.PartitionKey, item.RowKey)
	local skl = util.sharedkeylite({
		account = p.account, 
		key = p.key, 
		table = myTable })
	
	local url = string.format("https://%s.table.core.windows.net/%s", p.account, myTable)
	local auth = string.format('SharedKeyLite %s:%s', p.account, skl.signature)

	local response = http.request {
		method = 'PUT',
		url = url,
		data = json.stringify(item),
		headers = { 
			["Authorization"] = auth,
			["x-ms-date"] = skl.date,
			["Accept"] = "application/json;odata=nometadata",
			["x-ms-version"] = "2014-02-14",
			["Content-Type"] = "application/json"
		}
	}
	
	return response
end

-- retrieve an item
function retrieve(p, partitionKey, rowKey)
	return list(p, {
		filter = q,
		top = 1
		})
end

-- delete an item
function delete(table, partitionKey, rowKey)
	local myTable = string.format("%s(PartitionKey='%s',RowKey='%s')", p.table, partitionKey, rowKey)
	local skl = util.sharedkeylite({
		account = p.account, 
		key = p.key, 
		table = myTable })
	
	local url = string.format("https://%s.table.core.windows.net/%s", p.account, myTable)
	local auth = string.format('SharedKeyLite %s:%s', p.account, skl.signature)

	local response = http.request {
		method = 'DELETE',
		url = url,
		headers = { 
			["Authorization"] = auth,
			["x-ms-date"] = skl.date,
			["Accept"] = "application/json;odata=nometadata",
			["x-ms-version"] = "2014-02-14"
		}
	}
	
	return response
end

return {
	create = create,
	retrieve = retrieve,
	update = update,
	delete - delete,
	list = list
}