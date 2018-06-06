a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_scaleout_cluster_device_groups_device_group 'exampleName' do
    device_group 1

    client a10_client
    action :create
end

a10_scaleout_cluster_device_groups_device_group 'exampleName' do
    device_group 1

    client a10_client
    action :update
end

a10_scaleout_cluster_device_groups_device_group 'exampleName' do
    device_group 1

    client a10_client
    action :delete
end