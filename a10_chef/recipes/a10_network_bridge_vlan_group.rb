a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_network_bridge_vlan_group 'exampleName' do
    bridge_vlan_group_number 1

    client a10_client
    action :create
end

a10_network_bridge_vlan_group 'exampleName' do
    bridge_vlan_group_number 1

    client a10_client
    action :update
end

a10_network_bridge_vlan_group 'exampleName' do
    bridge_vlan_group_number 1

    client a10_client
    action :delete
end