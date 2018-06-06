a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_snmp_server_host_ipv6_host 'exampleName' do
    version "v1"

    client a10_client
    action :create
end

a10_snmp_server_host_ipv6_host 'exampleName' do
    version "v1"

    client a10_client
    action :update
end

a10_snmp_server_host_ipv6_host 'exampleName' do
    version "v1"

    client a10_client
    action :delete
end