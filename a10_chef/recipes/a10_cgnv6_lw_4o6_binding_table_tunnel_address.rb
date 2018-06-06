a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_lw_4o6_binding_table_tunnel_address 'exampleName' do

    client a10_client
    action :create
end

a10_cgnv6_lw_4o6_binding_table_tunnel_address 'exampleName' do

    client a10_client
    action :update
end

a10_cgnv6_lw_4o6_binding_table_tunnel_address 'exampleName' do

    client a10_client
    action :delete
end