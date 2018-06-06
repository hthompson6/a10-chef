a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_aam_authentication_logon_http_authenticate_instance 'exampleName' do

    client a10_client
    action :create
end

a10_aam_authentication_logon_http_authenticate_instance 'exampleName' do

    client a10_client
    action :update
end

a10_aam_authentication_logon_http_authenticate_instance 'exampleName' do

    client a10_client
    action :delete
end