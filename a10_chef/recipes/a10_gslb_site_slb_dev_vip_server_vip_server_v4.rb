a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_gslb_site_slb_dev_vip_server_vip_server_v4 'exampleName' do
    ipv4 "10.0.0.1"

    client a10_client
    action :create
end

a10_gslb_site_slb_dev_vip_server_vip_server_v4 'exampleName' do
    ipv4 "10.0.0.1"

    client a10_client
    action :update
end

a10_gslb_site_slb_dev_vip_server_vip_server_v4 'exampleName' do
    ipv4 "10.0.0.1"

    client a10_client
    action :delete
end