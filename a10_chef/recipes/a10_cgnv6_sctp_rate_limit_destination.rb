a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_sctp_rate_limit_destination 'exampleName' do
    ip "10.0.0.1"

    client a10_client
    action :create
end

a10_cgnv6_sctp_rate_limit_destination 'exampleName' do
    ip "10.0.0.1"

    client a10_client
    action :update
end

a10_cgnv6_sctp_rate_limit_destination 'exampleName' do
    ip "10.0.0.1"

    client a10_client
    action :delete
end