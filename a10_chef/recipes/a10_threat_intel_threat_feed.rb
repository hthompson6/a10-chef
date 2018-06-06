a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_threat_intel_threat_feed 'exampleName' do
    type "webroot"

    client a10_client
    action :create
end

a10_threat_intel_threat_feed 'exampleName' do
    type "webroot"

    client a10_client
    action :update
end

a10_threat_intel_threat_feed 'exampleName' do
    type "webroot"

    client a10_client
    action :delete
end