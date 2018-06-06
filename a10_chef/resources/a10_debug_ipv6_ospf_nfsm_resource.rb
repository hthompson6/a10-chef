resource_name :a10_debug_ipv6_ospf_nfsm

property :a10_name, String, name_property: true
property :status, [true, false]
property :timers, [true, false]
property :a10_events, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ipv6/ospf/"
    get_url = "/axapi/v3/debug/ipv6/ospf/nfsm"
    status = new_resource.status
    timers = new_resource.timers
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "nfsm": {"status": status,
        "timers": timers,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"nfsm"].each do |k, v|
        if not v 
            params[:"nfsm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nfsm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf/nfsm"
    status = new_resource.status
    timers = new_resource.timers
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "nfsm": {"status": status,
        "timers": timers,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"nfsm"].each do |k, v|
        if not v
            params[:"nfsm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nfsm"].each do |k, v|
        if v != params[:"nfsm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nfsm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf/nfsm"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nfsm') do
            client.delete(url)
        end
    end
end