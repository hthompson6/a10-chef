a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_lsn_stun_timeout_tcp 'exampleName' do
    port_start 1
    port_end 1

    client a10_client
    action :create
end

a10_cgnv6_lsn_stun_timeout_tcp 'exampleName' do
    port_start 1
    port_end 1

    client a10_client
    action :update
end

a10_cgnv6_lsn_stun_timeout_tcp 'exampleName' do
    port_start 1
    port_end 1

    client a10_client
    action :delete
end