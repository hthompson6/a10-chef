a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_aam_authentication_service_group_member 'exampleName' do
    port 1

    client a10_client
    action :create
end

a10_aam_authentication_service_group_member 'exampleName' do
    port 1

    client a10_client
    action :update
end

a10_aam_authentication_service_group_member 'exampleName' do
    port 1

    client a10_client
    action :delete
end