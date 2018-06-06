a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ldap_server_host_ldap_hostname 'exampleName' do

    client a10_client
    action :create
end

a10_ldap_server_host_ldap_hostname 'exampleName' do

    client a10_client
    action :update
end

a10_ldap_server_host_ldap_hostname 'exampleName' do

    client a10_client
    action :delete
end