resource_name :a10_virtual_server

property :a10_name, String, name_property: true
property :ip_address, String
property :url, String
property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    ip_address = new_resource.ip_address
    url = new_resource.url
    client.post(url, params: {"virtual-server" => {"name" => a10_name, "ip-address" => ip_address}}) 
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    ip_address = new_resource.ip_address
    url = new_resource.url
    client.put(url, params: {"virtual-sever" => {"name" => a10_name, "ip-address" => ip_address}})
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = new_resource.url
    client.delete(url+a10_name)
end
