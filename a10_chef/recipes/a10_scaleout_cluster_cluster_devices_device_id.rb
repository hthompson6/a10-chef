a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_scaleout_cluster_cluster_devices_device_id 'exampleName' do
    device_id 1

    client a10_client
    action :create
end

a10_scaleout_cluster_cluster_devices_device_id 'exampleName' do
    device_id 1

    client a10_client
    action :update
end

a10_scaleout_cluster_cluster_devices_device_id 'exampleName' do
    device_id 1

    client a10_client
    action :delete
end