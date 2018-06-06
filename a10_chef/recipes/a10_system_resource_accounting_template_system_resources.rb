a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_system_resource_accounting_template_system_resources 'exampleName' do

    client a10_client
    action :create
end

a10_system_resource_accounting_template_system_resources 'exampleName' do

    client a10_client
    action :update
end

a10_system_resource_accounting_template_system_resources 'exampleName' do

    client a10_client
    action :delete
end