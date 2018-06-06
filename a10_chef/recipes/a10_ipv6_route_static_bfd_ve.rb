a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ipv6_route_static_bfd_ve 'exampleName' do
    ve_num 2

    client a10_client
    action :create
end

a10_ipv6_route_static_bfd_ve 'exampleName' do
    ve_num 2

    client a10_client
    action :update
end

a10_ipv6_route_static_bfd_ve 'exampleName' do
    ve_num 2

    client a10_client
    action :delete
end