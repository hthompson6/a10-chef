a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_route_static_bfd 'exampleName' do
    local_ip "10.0.0.1"
    nexthop_ip "10.0.0.1"

    client a10_client
    action :create
end

a10_ip_route_static_bfd 'exampleName' do
    local_ip "10.0.0.1"
    nexthop_ip "10.0.0.1"

    client a10_client
    action :update
end

a10_ip_route_static_bfd 'exampleName' do
    local_ip "10.0.0.1"
    nexthop_ip "10.0.0.1"

    client a10_client
    action :delete
end