resource_name :a10_virtual_server

property :name, String
property :ip_address, String
property :url, String
proptery :client, Class

action :create do
    client.post(url, params: {"virtual-sever" => {"name" => name, "ip-address" => ip_address}}) 
end

action :update do
    client.put(url, params: {"virtual-sever" => {"name" => name, "ip-address" => ip_address}})
end

action :delete do
    client.delete(url+name)
end
