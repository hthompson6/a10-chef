a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_logging_email_filter 'exampleName' do
    filter_id 1

    client a10_client
    action :create
end

a10_logging_email_filter 'exampleName' do
    filter_id 1

    client a10_client
    action :update
end

a10_logging_email_filter 'exampleName' do
    filter_id 1

    client a10_client
    action :delete
end