a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_visibility_monitor 'exampleName' do
    primary_monitor "traffic"

    client a10_client
    action :create
end

a10_visibility_monitor 'exampleName' do
    primary_monitor "traffic"

    client a10_client
    action :update
end

a10_visibility_monitor 'exampleName' do
    primary_monitor "traffic"

    client a10_client
    action :delete
end