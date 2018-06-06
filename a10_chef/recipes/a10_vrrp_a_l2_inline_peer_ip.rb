a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_vrrp_a_l2_inline_peer_ip 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :create
end

a10_vrrp_a_l2_inline_peer_ip 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :update
end

a10_vrrp_a_l2_inline_peer_ip 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :delete
end