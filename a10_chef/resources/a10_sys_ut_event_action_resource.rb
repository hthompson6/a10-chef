resource_name :a10_sys_ut_event_action

property :a10_name, String, name_property: true
property :direction, ['send','expect','wait'],required: true
property :uuid, String
property :drop, [true, false]
property :udp, Hash
property :tcp, Hash
property :delay, Integer
property :l2, Hash
property :l3, Hash
property :template, String
property :ignore_validation, Hash
property :l1, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s"
    direction = new_resource.direction
    uuid = new_resource.uuid
    drop = new_resource.drop
    udp = new_resource.udp
    tcp = new_resource.tcp
    delay = new_resource.delay
    l2 = new_resource.l2
    l3 = new_resource.l3
    template = new_resource.template
    ignore_validation = new_resource.ignore_validation
    l1 = new_resource.l1

    params = { "action": {"direction": direction,
        "uuid": uuid,
        "drop": drop,
        "udp": udp,
        "tcp": tcp,
        "delay": delay,
        "l2": l2,
        "l3": l3,
        "template": template,
        "ignore-validation": ignore_validation,
        "l1": l1,} }

    params[:"action"].each do |k, v|
        if not v 
            params[:"action"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating action') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s"
    direction = new_resource.direction
    uuid = new_resource.uuid
    drop = new_resource.drop
    udp = new_resource.udp
    tcp = new_resource.tcp
    delay = new_resource.delay
    l2 = new_resource.l2
    l3 = new_resource.l3
    template = new_resource.template
    ignore_validation = new_resource.ignore_validation
    l1 = new_resource.l1

    params = { "action": {"direction": direction,
        "uuid": uuid,
        "drop": drop,
        "udp": udp,
        "tcp": tcp,
        "delay": delay,
        "l2": l2,
        "l3": l3,
        "template": template,
        "ignore-validation": ignore_validation,
        "l1": l1,} }

    params[:"action"].each do |k, v|
        if not v
            params[:"action"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["action"].each do |k, v|
        if v != params[:"action"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating action') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting action') do
            client.delete(url)
        end
    end
end