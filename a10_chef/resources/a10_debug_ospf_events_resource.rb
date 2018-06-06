resource_name :a10_debug_ospf_events

property :a10_name, String, name_property: true
property :asbr, [true, false]
property :uuid, String
property :abr, [true, false]
property :router, [true, false]
property :vlink, [true, false]
property :os, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ospf/"
    get_url = "/axapi/v3/debug/ospf/events"
    asbr = new_resource.asbr
    uuid = new_resource.uuid
    abr = new_resource.abr
    router = new_resource.router
    vlink = new_resource.vlink
    os = new_resource.os

    params = { "events": {"asbr": asbr,
        "uuid": uuid,
        "abr": abr,
        "router": router,
        "vlink": vlink,
        "os": os,} }

    params[:"events"].each do |k, v|
        if not v 
            params[:"events"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating events') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/events"
    asbr = new_resource.asbr
    uuid = new_resource.uuid
    abr = new_resource.abr
    router = new_resource.router
    vlink = new_resource.vlink
    os = new_resource.os

    params = { "events": {"asbr": asbr,
        "uuid": uuid,
        "abr": abr,
        "router": router,
        "vlink": vlink,
        "os": os,} }

    params[:"events"].each do |k, v|
        if not v
            params[:"events"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["events"].each do |k, v|
        if v != params[:"events"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating events') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ospf/events"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting events') do
            client.delete(url)
        end
    end
end