a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_network_vlan 'exampleName' do
    vlan_num 2

    client a10_client
    action :create
end

a10_network_vlan 'exampleName' do
    vlan_num 2

    client a10_client
    action :update
end

a10_network_vlan 'exampleName' do
    vlan_num 2

    client a10_client
    action :delete
end