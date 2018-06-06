a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ntp_trusted_key 'exampleName' do
    key 1

    client a10_client
    action :create
end

a10_ntp_trusted_key 'exampleName' do
    key 1

    client a10_client
    action :update
end

a10_ntp_trusted_key 'exampleName' do
    key 1

    client a10_client
    action :delete
end