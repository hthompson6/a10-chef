a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_rule_set_rule_move_rule 'exampleName' do

    client a10_client
    action :create
end

a10_rule_set_rule_move_rule 'exampleName' do

    client a10_client
    action :update
end

a10_rule_set_rule_move_rule 'exampleName' do

    client a10_client
    action :delete
end