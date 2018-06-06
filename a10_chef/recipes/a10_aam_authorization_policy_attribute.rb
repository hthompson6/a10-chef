a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_aam_authorization_policy_attribute 'exampleName' do
    attr_num 1

    client a10_client
    action :create
end

a10_aam_authorization_policy_attribute 'exampleName' do
    attr_num 1

    client a10_client
    action :update
end

a10_aam_authorization_policy_attribute 'exampleName' do
    attr_num 1

    client a10_client
    action :delete
end