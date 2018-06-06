a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_harmony_controller_profile 'exampleName' do

    client a10_client
    action :create
end

a10_harmony_controller_profile 'exampleName' do

    client a10_client
    action :update
end

a10_harmony_controller_profile 'exampleName' do

    client a10_client
    action :delete
end