a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_aam_authentication_relay_form_based_instance_request_uri 'exampleName' do
    match_type "equals"

    client a10_client
    action :create
end

a10_aam_authentication_relay_form_based_instance_request_uri 'exampleName' do
    match_type "equals"

    client a10_client
    action :update
end

a10_aam_authentication_relay_form_based_instance_request_uri 'exampleName' do
    match_type "equals"

    client a10_client
    action :delete
end