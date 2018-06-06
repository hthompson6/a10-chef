a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_slb_service_group 'exampleName' do
    protocol "tcp"
    member_list [{'host': '10.20.42.1', 'name': 'sg1-member1', 'port': 443}]
    lb_method "dst-ip-hash"

    client a10_client
    action :create
end

a10_slb_service_group 'exampleName' do
    protocol "tcp"
    member_list [{'host': '10.20.42.1', 'name': 'sg1-member1', 'port': 443}]
    lb_method "dst-ip-hash"

    client a10_client
    action :update
end

a10_slb_service_group 'exampleName' do
    protocol "tcp"
    member_list [{'host': '10.20.42.1', 'name': 'sg1-member1', 'port': 443}]
    lb_method "dst-ip-hash"

    client a10_client
    action :delete
end