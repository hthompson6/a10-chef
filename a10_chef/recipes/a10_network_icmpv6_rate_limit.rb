a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_network_icmpv6_rate_limit 'exampleName' do

    client a10_client
    action :create
end

a10_network_icmpv6_rate_limit 'exampleName' do

    client a10_client
    action :update
end

a10_network_icmpv6_rate_limit 'exampleName' do

    client a10_client
    action :delete
end