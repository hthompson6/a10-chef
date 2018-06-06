a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_automatic_update_config 'exampleName' do
    feature_name "app-fw"

    client a10_client
    action :create
end

a10_automatic_update_config 'exampleName' do
    feature_name "app-fw"

    client a10_client
    action :update
end

a10_automatic_update_config 'exampleName' do
    feature_name "app-fw"

    client a10_client
    action :delete
end