a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_network_arp_static 'exampleName' do
    vlan 2
    ip_addr "10.0.0.1"

    client a10_client
    action :create
end

a10_network_arp_static 'exampleName' do
    vlan 2
    ip_addr "10.0.0.1"

    client a10_client
    action :update
end

a10_network_arp_static 'exampleName' do
    vlan 2
    ip_addr "10.0.0.1"

    client a10_client
    action :delete
end