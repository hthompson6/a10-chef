a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_cgnv6_ds_lite_port_reservation 'exampleName' do
    nat_end_port 1
    inside_start_port 1
    nat "10.0.0.1"
    inside_end_port 1
    nat_start_port 1
    inside_addr "10.0.0.1"

    client a10_client
    action :create
end

a10_cgnv6_ds_lite_port_reservation 'exampleName' do
    nat_end_port 1
    inside_start_port 1
    nat "10.0.0.1"
    inside_end_port 1
    nat_start_port 1
    inside_addr "10.0.0.1"

    client a10_client
    action :update
end

a10_cgnv6_ds_lite_port_reservation 'exampleName' do
    nat_end_port 1
    inside_start_port 1
    nat "10.0.0.1"
    inside_end_port 1
    nat_start_port 1
    inside_addr "10.0.0.1"

    client a10_client
    action :delete
end