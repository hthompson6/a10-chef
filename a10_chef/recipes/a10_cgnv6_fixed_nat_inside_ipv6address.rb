a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_fixed_nat_inside_ipv6address 'exampleName' do
    inside_netmask 64

    client a10_client
    action :create
end

a10_cgnv6_fixed_nat_inside_ipv6address 'exampleName' do
    inside_netmask 64

    client a10_client
    action :update
end

a10_cgnv6_fixed_nat_inside_ipv6address 'exampleName' do
    inside_netmask 64

    client a10_client
    action :delete
end