a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_radius_server_host_ipv4 'exampleName' do
    ipv4_addr "10.0.0.1"

    client a10_client
    action :create
end

a10_radius_server_host_ipv4 'exampleName' do
    ipv4_addr "10.0.0.1"

    client a10_client
    action :update
end

a10_radius_server_host_ipv4 'exampleName' do
    ipv4_addr "10.0.0.1"

    client a10_client
    action :delete
end