a10_client = A10Client::client_factory(host, port, protocol, username, password)

a10_health_monitor 'exampleName' do
    up_retry 1
    retry 1
    method {'tcp': {'port-send': '[42, 42, 42]', 'method-tcp': 1, 'port-resp': {'port-contains': '[45, 45, 45]'}, 'tcp-port': 80}}

    client a10_client
    action :create
end

a10_health_monitor 'exampleName' do
    up_retry 1
    retry 1
    method {'tcp': {'port-send': '[42, 42, 42]', 'method-tcp': 1, 'port-resp': {'port-contains': '[45, 45, 45]'}, 'tcp-port': 80}}

    client a10_client
    action :update
end

a10_health_monitor 'exampleName' do
    up_retry 1
    retry 1
    method {'tcp': {'port-send': '[42, 42, 42]', 'method-tcp': 1, 'port-resp': {'port-contains': '[45, 45, 45]'}, 'tcp-port': 80}}

    client a10_client
    action :delete
end