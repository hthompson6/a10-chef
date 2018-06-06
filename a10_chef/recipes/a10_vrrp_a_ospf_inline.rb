a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_vrrp_a_ospf_inline 'exampleName' do
    vlan 1

    client a10_client
    action :create
end

a10_vrrp_a_ospf_inline 'exampleName' do
    vlan 1

    client a10_client
    action :update
end

a10_vrrp_a_ospf_inline 'exampleName' do
    vlan 1

    client a10_client
    action :delete
end