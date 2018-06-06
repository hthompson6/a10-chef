a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_vrrp_a_vrid_blade_parameters_tracking_options_gateway_ipv4_gateway 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :create
end

a10_vrrp_a_vrid_blade_parameters_tracking_options_gateway_ipv4_gateway 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :update
end

a10_vrrp_a_vrid_blade_parameters_tracking_options_gateway_ipv4_gateway 'exampleName' do
    ip_address "10.0.0.1"

    client a10_client
    action :delete
end