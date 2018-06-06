a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_overlay_tunnel_vtep_destination_ip_address_vni 'exampleName' do
    segment 1

    client a10_client
    action :create
end

a10_overlay_tunnel_vtep_destination_ip_address_vni 'exampleName' do
    segment 1

    client a10_client
    action :update
end

a10_overlay_tunnel_vtep_destination_ip_address_vni 'exampleName' do
    segment 1

    client a10_client
    action :delete
end