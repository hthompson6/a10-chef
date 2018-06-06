a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_vrrp_a_preferred_session_sync_port_trunk 'exampleName' do
    pre_trunk 1

    client a10_client
    action :create
end

a10_vrrp_a_preferred_session_sync_port_trunk 'exampleName' do
    pre_trunk 1

    client a10_client
    action :update
end

a10_vrrp_a_preferred_session_sync_port_trunk 'exampleName' do
    pre_trunk 1

    client a10_client
    action :delete
end