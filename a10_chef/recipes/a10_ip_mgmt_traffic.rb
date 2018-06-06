a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_mgmt_traffic 'exampleName' do
    traffic_type "all"

    client a10_client
    action :create
end

a10_ip_mgmt_traffic 'exampleName' do
    traffic_type "all"

    client a10_client
    action :update
end

a10_ip_mgmt_traffic 'exampleName' do
    traffic_type "all"

    client a10_client
    action :delete
end