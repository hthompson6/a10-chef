a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_enable_management_service_http_acl_v6 'exampleName' do

    client a10_client
    action :create
end

a10_enable_management_service_http_acl_v6 'exampleName' do

    client a10_client
    action :update
end

a10_enable_management_service_http_acl_v6 'exampleName' do

    client a10_client
    action :delete
end