a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_router_bgp 'exampleName' do
    as_number 1

    client a10_client
    action :create
end

a10_router_bgp 'exampleName' do
    as_number 1

    client a10_client
    action :update
end

a10_router_bgp 'exampleName' do
    as_number 1

    client a10_client
    action :delete
end