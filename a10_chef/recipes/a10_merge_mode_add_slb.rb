a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_merge_mode_add_slb 'exampleName' do

    client a10_client
    action :create
end

a10_merge_mode_add_slb 'exampleName' do

    client a10_client
    action :update
end

a10_merge_mode_add_slb 'exampleName' do

    client a10_client
    action :delete
end