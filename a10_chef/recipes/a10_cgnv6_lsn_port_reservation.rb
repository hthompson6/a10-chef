a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_lsn_port_reservation 'exampleName' do
    inside_port_start 1
    nat_port_start 1
    inside_port_end 1
    inside "10.0.0.1"
    nat "10.0.0.1"
    nat_port_end 1

    client a10_client
    action :create
end

a10_cgnv6_lsn_port_reservation 'exampleName' do
    inside_port_start 1
    nat_port_start 1
    inside_port_end 1
    inside "10.0.0.1"
    nat "10.0.0.1"
    nat_port_end 1

    client a10_client
    action :update
end

a10_cgnv6_lsn_port_reservation 'exampleName' do
    inside_port_start 1
    nat_port_start 1
    inside_port_end 1
    inside "10.0.0.1"
    nat "10.0.0.1"
    nat_port_end 1

    client a10_client
    action :delete
end