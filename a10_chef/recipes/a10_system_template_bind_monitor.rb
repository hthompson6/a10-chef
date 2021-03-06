a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_system_template_bind_monitor 'exampleName' do
    template_monitor 1

    client a10_client
    action :create
end

a10_system_template_bind_monitor 'exampleName' do
    template_monitor 1

    client a10_client
    action :update
end

a10_system_template_bind_monitor 'exampleName' do
    template_monitor 1

    client a10_client
    action :delete
end