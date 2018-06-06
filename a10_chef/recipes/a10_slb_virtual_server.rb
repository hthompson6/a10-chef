a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_slb_virtual_server 'exampleName' do
    port_list [{'protocol': 'https', 'port-number': 443}, {'protocol': 'http', 'port-number': 80, 'template-persist-cookie': 'sg-cookie-persist'}, {'protocol': 'tcp', 'port-number': 22}]
    ip_address "192.168.42.1"
    netmask "255.255.255.0"

    client a10_client
    action :create
end

a10_slb_virtual_server 'exampleName' do
    port_list [{'protocol': 'https', 'port-number': 443}, {'protocol': 'http', 'port-number': 80, 'template-persist-cookie': 'sg-cookie-persist'}, {'protocol': 'tcp', 'port-number': 22}]
    ip_address "192.168.42.1"
    netmask "255.255.255.0"

    client a10_client
    action :update
end

a10_slb_virtual_server 'exampleName' do
    port_list [{'protocol': 'https', 'port-number': 443}, {'protocol': 'http', 'port-number': 80, 'template-persist-cookie': 'sg-cookie-persist'}, {'protocol': 'tcp', 'port-number': 22}]
    ip_address "192.168.42.1"
    netmask "255.255.255.0"

    client a10_client
    action :delete
end