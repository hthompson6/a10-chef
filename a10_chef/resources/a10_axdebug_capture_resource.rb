resource_name :a10_axdebug_capture

property :a10_name, String, name_property: true
property :current_slot, [true, false]
property :outgoing, [true, false]
property :non_display, [true, false]
property :incoming, [true, false]
property :port_num, String
property :brief, [true, false]
property :detail, [true, false]
property :save, String
property :max_packets, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/axdebug/"
    get_url = "/axapi/v3/axdebug/capture"
    current_slot = new_resource.current_slot
    outgoing = new_resource.outgoing
    non_display = new_resource.non_display
    incoming = new_resource.incoming
    port_num = new_resource.port_num
    brief = new_resource.brief
    detail = new_resource.detail
    save = new_resource.save
    max_packets = new_resource.max_packets

    params = { "capture": {"current-slot": current_slot,
        "outgoing": outgoing,
        "non-display": non_display,
        "incoming": incoming,
        "port-num": port_num,
        "brief": brief,
        "detail": detail,
        "save": save,
        "max-packets": max_packets,} }

    params[:"capture"].each do |k, v|
        if not v 
            params[:"capture"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating capture') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug/capture"
    current_slot = new_resource.current_slot
    outgoing = new_resource.outgoing
    non_display = new_resource.non_display
    incoming = new_resource.incoming
    port_num = new_resource.port_num
    brief = new_resource.brief
    detail = new_resource.detail
    save = new_resource.save
    max_packets = new_resource.max_packets

    params = { "capture": {"current-slot": current_slot,
        "outgoing": outgoing,
        "non-display": non_display,
        "incoming": incoming,
        "port-num": port_num,
        "brief": brief,
        "detail": detail,
        "save": save,
        "max-packets": max_packets,} }

    params[:"capture"].each do |k, v|
        if not v
            params[:"capture"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["capture"].each do |k, v|
        if v != params[:"capture"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating capture') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/axdebug/capture"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting capture') do
            client.delete(url)
        end
    end
end