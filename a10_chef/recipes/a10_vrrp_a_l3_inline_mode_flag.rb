a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_vrrp_a_l3_inline_mode_flag 'exampleName' do

    client a10_client
    action :create
end

a10_vrrp_a_l3_inline_mode_flag 'exampleName' do

    client a10_client
    action :update
end

a10_vrrp_a_l3_inline_mode_flag 'exampleName' do

    client a10_client
    action :delete
end