a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_nat46_stateless_static_dest_mapping 'exampleName' do
    v4_address "10.0.0.1"

    client a10_client
    action :create
end

a10_cgnv6_nat46_stateless_static_dest_mapping 'exampleName' do
    v4_address "10.0.0.1"

    client a10_client
    action :update
end

a10_cgnv6_nat46_stateless_static_dest_mapping 'exampleName' do
    v4_address "10.0.0.1"

    client a10_client
    action :delete
end