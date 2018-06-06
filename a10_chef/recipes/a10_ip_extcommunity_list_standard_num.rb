a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_extcommunity_list_standard_num 'exampleName' do
    std_list_num 1

    client a10_client
    action :create
end

a10_ip_extcommunity_list_standard_num 'exampleName' do
    std_list_num 1

    client a10_client
    action :update
end

a10_ip_extcommunity_list_standard_num 'exampleName' do
    std_list_num 1

    client a10_client
    action :delete
end