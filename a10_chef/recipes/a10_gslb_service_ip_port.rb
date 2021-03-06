a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_gslb_service_ip_port 'exampleName' do
    port_proto "tcp"

    client a10_client
    action :create
end

a10_gslb_service_ip_port 'exampleName' do
    port_proto "tcp"

    client a10_client
    action :update
end

a10_gslb_service_ip_port 'exampleName' do
    port_proto "tcp"

    client a10_client
    action :delete
end