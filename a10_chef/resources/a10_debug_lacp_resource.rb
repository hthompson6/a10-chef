resource_name :a10_debug_lacp

property :a10_name, String, name_property: true
property :all, [true, false]
property :cli, [true, false]
property :detail, [true, false]
property :timer, [true, false]
property :sync, [true, false]
property :packet, [true, false]
property :ha, [true, false]
property :event, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/lacp"
    all = new_resource.all
    cli = new_resource.cli
    detail = new_resource.detail
    timer = new_resource.timer
    sync = new_resource.sync
    packet = new_resource.packet
    ha = new_resource.ha
    event = new_resource.event
    uuid = new_resource.uuid

    params = { "lacp": {"all": all,
        "cli": cli,
        "detail": detail,
        "timer": timer,
        "sync": sync,
        "packet": packet,
        "ha": ha,
        "event": event,
        "uuid": uuid,} }

    params[:"lacp"].each do |k, v|
        if not v 
            params[:"lacp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lacp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/lacp"
    all = new_resource.all
    cli = new_resource.cli
    detail = new_resource.detail
    timer = new_resource.timer
    sync = new_resource.sync
    packet = new_resource.packet
    ha = new_resource.ha
    event = new_resource.event
    uuid = new_resource.uuid

    params = { "lacp": {"all": all,
        "cli": cli,
        "detail": detail,
        "timer": timer,
        "sync": sync,
        "packet": packet,
        "ha": ha,
        "event": event,
        "uuid": uuid,} }

    params[:"lacp"].each do |k, v|
        if not v
            params[:"lacp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lacp"].each do |k, v|
        if v != params[:"lacp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lacp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/lacp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lacp') do
            client.delete(url)
        end
    end
end