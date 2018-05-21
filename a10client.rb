require_relative 'axapi_http'

client = A10Client::client_factory('10.48.6.222', 'https', 443, 'admin', 'a10')

client.post("/axapi/v3/slb/virtual-server/slb4", params: {"ip_address" => "1.1.1.1"})
