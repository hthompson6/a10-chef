a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_stateful_firewall_udp_stun_timeout 'exampleName' do
    port_end 1
    port 1

    client a10_client
    action :create
end

a10_cgnv6_stateful_firewall_udp_stun_timeout 'exampleName' do
    port_end 1
    port 1

    client a10_client
    action :update
end

a10_cgnv6_stateful_firewall_udp_stun_timeout 'exampleName' do
    port_end 1
    port 1

    client a10_client
    action :delete
end