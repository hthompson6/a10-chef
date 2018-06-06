resource_name :a10_interface_management

property :a10_name, String, name_property: true
property :lldp, Hash
property :flow_control, [true, false]
property :broadcast_rate_limit, Hash
property :uuid, String
property :duplexity, ['Full','Half','auto']
property :ip, Hash
property :secondary_ip, Hash
property :access_list, Hash
property :ipv6, Hash
property :a10_action, ['enable','disable']
property :speed, ['10','100','1000','auto']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/"
    get_url = "/axapi/v3/interface/management"
    lldp = new_resource.lldp
    flow_control = new_resource.flow_control
    broadcast_rate_limit = new_resource.broadcast_rate_limit
    uuid = new_resource.uuid
    duplexity = new_resource.duplexity
    ip = new_resource.ip
    secondary_ip = new_resource.secondary_ip
    access_list = new_resource.access_list
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name
    speed = new_resource.speed

    params = { "management": {"lldp": lldp,
        "flow-control": flow_control,
        "broadcast-rate-limit": broadcast_rate_limit,
        "uuid": uuid,
        "duplexity": duplexity,
        "ip": ip,
        "secondary-ip": secondary_ip,
        "access-list": access_list,
        "ipv6": ipv6,
        "action": a10_action,
        "speed": speed,} }

    params[:"management"].each do |k, v|
        if not v 
            params[:"management"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating management') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/management"
    lldp = new_resource.lldp
    flow_control = new_resource.flow_control
    broadcast_rate_limit = new_resource.broadcast_rate_limit
    uuid = new_resource.uuid
    duplexity = new_resource.duplexity
    ip = new_resource.ip
    secondary_ip = new_resource.secondary_ip
    access_list = new_resource.access_list
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name
    speed = new_resource.speed

    params = { "management": {"lldp": lldp,
        "flow-control": flow_control,
        "broadcast-rate-limit": broadcast_rate_limit,
        "uuid": uuid,
        "duplexity": duplexity,
        "ip": ip,
        "secondary-ip": secondary_ip,
        "access-list": access_list,
        "ipv6": ipv6,
        "action": a10_action,
        "speed": speed,} }

    params[:"management"].each do |k, v|
        if not v
            params[:"management"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["management"].each do |k, v|
        if v != params[:"management"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating management') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/management"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting management') do
            client.delete(url)
        end
    end
end