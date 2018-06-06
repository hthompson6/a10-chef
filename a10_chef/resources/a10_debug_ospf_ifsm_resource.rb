resource_name :a10_debug_ospf_ifsm

property :a10_name, String, name_property: true
property :status, [true, false]
property :timers, [true, false]
property :a10_events, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ospf/"
    get_url = "/axapi/v3/debug/ospf/ifsm"
    status = new_resource.status
    timers = new_resource.timers
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "ifsm": {"status": status,
        "timers": timers,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"ifsm"].each do |k, v|
        if not v 
            params[:"ifsm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ifsm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/ifsm"
    status = new_resource.status
    timers = new_resource.timers
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "ifsm": {"status": status,
        "timers": timers,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"ifsm"].each do |k, v|
        if not v
            params[:"ifsm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ifsm"].each do |k, v|
        if v != params[:"ifsm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ifsm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/ifsm"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ifsm') do
            client.delete(url)
        end
    end
end