a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_ip_nat_inside_source_list_acl_id_list 'exampleName' do
    acl_id 1

    client a10_client
    action :create
end

a10_ip_nat_inside_source_list_acl_id_list 'exampleName' do
    acl_id 1

    client a10_client
    action :update
end

a10_ip_nat_inside_source_list_acl_id_list 'exampleName' do
    acl_id 1

    client a10_client
    action :delete
end