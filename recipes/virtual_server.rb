a10_client = A10Client::client_factory('X.X.X.X', '80', 'http', 'admin', 'password')

a10_virtual_server 'slb1' do
    url '/axapi/v3/slb/virtual-server/'
    ip_address '1.1.1.4'
    client a10_client
    action :create
end
