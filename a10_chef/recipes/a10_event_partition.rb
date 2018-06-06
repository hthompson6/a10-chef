a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_event_partition 'exampleName' do
    vnp_events "part-create"

    client a10_client
    action :create
end

a10_event_partition 'exampleName' do
    vnp_events "part-create"

    client a10_client
    action :update
end

a10_event_partition 'exampleName' do
    vnp_events "part-create"

    client a10_client
    action :delete
end