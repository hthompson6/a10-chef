a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_import_periodic_ssl_cert_key 'exampleName' do
    ssl_cert_key "bulk"

    client a10_client
    action :create
end

a10_import_periodic_ssl_cert_key 'exampleName' do
    ssl_cert_key "bulk"

    client a10_client
    action :update
end

a10_import_periodic_ssl_cert_key 'exampleName' do
    ssl_cert_key "bulk"

    client a10_client
    action :delete
end