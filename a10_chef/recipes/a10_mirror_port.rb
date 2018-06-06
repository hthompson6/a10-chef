a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_mirror_port 'exampleName' do
    mirror_index 1

    client a10_client
    action :create
end

a10_mirror_port 'exampleName' do
    mirror_index 1

    client a10_client
    action :update
end

a10_mirror_port 'exampleName' do
    mirror_index 1

    client a10_client
    action :delete
end