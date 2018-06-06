a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_overlay_tunnel_vtep_host 'exampleName' do
    destination_vtep "10.0.0.1"
    ip_addr "10.0.0.1"
    vni 1

    client a10_client
    action :create
end

a10_overlay_tunnel_vtep_host 'exampleName' do
    destination_vtep "10.0.0.1"
    ip_addr "10.0.0.1"
    vni 1

    client a10_client
    action :update
end

a10_overlay_tunnel_vtep_host 'exampleName' do
    destination_vtep "10.0.0.1"
    ip_addr "10.0.0.1"
    vni 1

    client a10_client
    action :delete
end