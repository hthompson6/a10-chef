a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_nat_inside_source_static 'exampleName' do
    src_address "10.0.0.1"

    client a10_client
    action :create
end

a10_cgnv6_nat_inside_source_static 'exampleName' do
    src_address "10.0.0.1"

    client a10_client
    action :update
end

a10_cgnv6_nat_inside_source_static 'exampleName' do
    src_address "10.0.0.1"

    client a10_client
    action :delete
end