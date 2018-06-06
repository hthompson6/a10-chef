a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_overlay_tunnel_vtep_source_ip_address 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :create
end

a10_overlay_tunnel_vtep_source_ip_address 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :update
end

a10_overlay_tunnel_vtep_source_ip_address 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :delete
end