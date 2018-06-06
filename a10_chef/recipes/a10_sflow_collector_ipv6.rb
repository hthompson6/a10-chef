a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_sflow_collector_ipv6 'exampleName' do
    port 1

    client a10_client
    action :create
end

a10_sflow_collector_ipv6 'exampleName' do
    port 1

    client a10_client
    action :update
end

a10_sflow_collector_ipv6 'exampleName' do
    port 1

    client a10_client
    action :delete
end