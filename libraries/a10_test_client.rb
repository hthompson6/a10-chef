require_relative 'axapi_http'

client = A10Client::client_factory('X.X.X.X', 'http', 80, 'admin', 'password')

client.post("/axapi/v3/slb/virtual-server/", params: {"virtual-server" => {"name" => "slb7", "ip-address" => "1.1.1.10"}})
