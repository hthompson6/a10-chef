a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_extcommunity_list_standard 'exampleName' do

    client a10_client
    action :create
end

a10_ip_extcommunity_list_standard 'exampleName' do

    client a10_client
    action :update
end

a10_ip_extcommunity_list_standard 'exampleName' do

    client a10_client
    action :delete
end