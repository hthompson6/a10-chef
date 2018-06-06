a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_Generates aVCS debug file 'exampleName' do

    client a10_client
    action :create
end

a10_Generates aVCS debug file 'exampleName' do

    client a10_client
    action :update
end

a10_Generates aVCS debug file 'exampleName' do

    client a10_client
    action :delete
end