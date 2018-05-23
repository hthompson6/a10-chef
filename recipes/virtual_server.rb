a10_client = A10Client.client_factory('10.48.6.222', '443', 'https', 'admin', 'a10')

virtual_server_resource 'slb5' do
    url '/axapi/v3/slb/virtual-server/'
    name 'slb5'
    ip_address '1.1.1.4'
    client a10_client
    action :create
end
