a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_access_list_extended 'exampleName' do
    extd 100

    client a10_client
    action :create
end

a10_access_list_extended 'exampleName' do
    extd 100

    client a10_client
    action :update
end

a10_access_list_extended 'exampleName' do
    extd 100

    client a10_client
    action :delete
end