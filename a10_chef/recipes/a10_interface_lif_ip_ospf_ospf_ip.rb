a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_interface_lif_ip_ospf_ospf_ip 'exampleName' do
    ip_addr "10.0.0.1"

    client a10_client
    action :create
end

a10_interface_lif_ip_ospf_ospf_ip 'exampleName' do
    ip_addr "10.0.0.1"

    client a10_client
    action :update
end

a10_interface_lif_ip_ospf_ospf_ip 'exampleName' do
    ip_addr "10.0.0.1"

    client a10_client
    action :delete
end