a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_stateful_firewall_udp_idle_timeout 'exampleName' do
    port 1
    port_end 1

    client a10_client
    action :create
end

a10_cgnv6_stateful_firewall_udp_idle_timeout 'exampleName' do
    port 1
    port_end 1

    client a10_client
    action :update
end

a10_cgnv6_stateful_firewall_udp_idle_timeout 'exampleName' do
    port 1
    port_end 1

    client a10_client
    action :delete
end