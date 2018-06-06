resource_name :a10_debug_ipv6_rip

property :a10_name, String, name_property: true
property :all, [true, false]
property :nsm, [true, false]
property :detail, [true, false]
property :a10_send, [true, false]
property :packet, [true, false]
property :recv, [true, false]
property :a10_events, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ipv6/"
    get_url = "/axapi/v3/debug/ipv6/rip"
    all = new_resource.all
    nsm = new_resource.nsm
    detail = new_resource.detail
    a10_name = new_resource.a10_name
    packet = new_resource.packet
    recv = new_resource.recv
    a10_name = new_resource.a10_name

    params = { "rip": {"all": all,
        "nsm": nsm,
        "detail": detail,
        "send": a10_send,
        "packet": packet,
        "recv": recv,
        "events": a10_events,} }

    params[:"rip"].each do |k, v|
        if not v 
            params[:"rip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/rip"
    all = new_resource.all
    nsm = new_resource.nsm
    detail = new_resource.detail
    a10_name = new_resource.a10_name
    packet = new_resource.packet
    recv = new_resource.recv
    a10_name = new_resource.a10_name

    params = { "rip": {"all": all,
        "nsm": nsm,
        "detail": detail,
        "send": a10_send,
        "packet": packet,
        "recv": recv,
        "events": a10_events,} }

    params[:"rip"].each do |k, v|
        if not v
            params[:"rip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rip"].each do |k, v|
        if v != params[:"rip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/rip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rip') do
            client.delete(url)
        end
    end
end