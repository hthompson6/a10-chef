resource_name :a10_gslb_active_rdt

property :a10_name, String, name_property: true
property :domain, String
property :a10_retry, Integer
property :uuid, String
property :track, Integer
property :interval, Integer
property :sleep, Integer
property :timeout, Integer
property :icmp, [true, false]
property :port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/"
    get_url = "/axapi/v3/gslb/active-rdt"
    domain = new_resource.domain
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    track = new_resource.track
    interval = new_resource.interval
    sleep = new_resource.sleep
    timeout = new_resource.timeout
    icmp = new_resource.icmp
    port = new_resource.port

    params = { "active-rdt": {"domain": domain,
        "retry": a10_retry,
        "uuid": uuid,
        "track": track,
        "interval": interval,
        "sleep": sleep,
        "timeout": timeout,
        "icmp": icmp,
        "port": port,} }

    params[:"active-rdt"].each do |k, v|
        if not v 
            params[:"active-rdt"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating active-rdt') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/active-rdt"
    domain = new_resource.domain
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    track = new_resource.track
    interval = new_resource.interval
    sleep = new_resource.sleep
    timeout = new_resource.timeout
    icmp = new_resource.icmp
    port = new_resource.port

    params = { "active-rdt": {"domain": domain,
        "retry": a10_retry,
        "uuid": uuid,
        "track": track,
        "interval": interval,
        "sleep": sleep,
        "timeout": timeout,
        "icmp": icmp,
        "port": port,} }

    params[:"active-rdt"].each do |k, v|
        if not v
            params[:"active-rdt"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["active-rdt"].each do |k, v|
        if v != params[:"active-rdt"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating active-rdt') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/active-rdt"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting active-rdt') do
            client.delete(url)
        end
    end
end