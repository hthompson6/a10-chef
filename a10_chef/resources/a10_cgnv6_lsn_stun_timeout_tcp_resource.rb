resource_name :a10_cgnv6_lsn_stun_timeout_tcp

property :a10_name, String, name_property: true
property :port_start, Integer,required: true
property :port_end, Integer,required: true
property :timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/stun-timeout/tcp/"
    get_url = "/axapi/v3/cgnv6/lsn/stun-timeout/tcp/%<port-start>s+%<port-end>s"
    port_start = new_resource.port_start
    port_end = new_resource.port_end
    timeout = new_resource.timeout
    uuid = new_resource.uuid

    params = { "tcp": {"port-start": port_start,
        "port-end": port_end,
        "timeout": timeout,
        "uuid": uuid,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/stun-timeout/tcp/%<port-start>s+%<port-end>s"
    port_start = new_resource.port_start
    port_end = new_resource.port_end
    timeout = new_resource.timeout
    uuid = new_resource.uuid

    params = { "tcp": {"port-start": port_start,
        "port-end": port_end,
        "timeout": timeout,
        "uuid": uuid,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/stun-timeout/tcp/%<port-start>s+%<port-end>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end