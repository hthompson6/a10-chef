a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ssh_login_grace_time 'exampleName' do

    client a10_client
    action :create
end

a10_ssh_login_grace_time 'exampleName' do

    client a10_client
    action :update
end

a10_ssh_login_grace_time 'exampleName' do

    client a10_client
    action :delete
end