a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_slb_template_persist_destination_ip 'exampleName' do

    client a10_client
    action :create
end

a10_slb_template_persist_destination_ip 'exampleName' do

    client a10_client
    action :update
end

a10_slb_template_persist_destination_ip 'exampleName' do

    client a10_client
    action :delete
end