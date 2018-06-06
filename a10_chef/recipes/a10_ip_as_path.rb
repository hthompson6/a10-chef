a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_as_path 'exampleName' do
    action "deny"

    client a10_client
    action :create
end

a10_ip_as_path 'exampleName' do
    action "deny"

    client a10_client
    action :update
end

a10_ip_as_path 'exampleName' do
    action "deny"

    client a10_client
    action :delete
end