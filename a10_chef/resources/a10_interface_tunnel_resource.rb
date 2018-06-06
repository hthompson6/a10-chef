resource_name :a10_interface_tunnel

property :a10_name, String, name_property: true
property :ip, Hash
property :user_tag, String
property :mtu, Integer
property :ifnum, Integer,required: true
property :load_interval, Integer
property :ipv6, Hash
property :a10_action, ['enable','disable']
property :speed, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/tunnel/"
    get_url = "/axapi/v3/interface/tunnel/%<ifnum>s"
    a10_name = new_resource.a10_name
    ip = new_resource.ip
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ifnum = new_resource.ifnum
    load_interval = new_resource.load_interval
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name
    speed = new_resource.speed
    uuid = new_resource.uuid

    params = { "tunnel": {"name": a10_name,
        "ip": ip,
        "user-tag": user_tag,
        "mtu": mtu,
        "ifnum": ifnum,
        "load-interval": load_interval,
        "ipv6": ipv6,
        "action": a10_action,
        "speed": speed,
        "uuid": uuid,} }

    params[:"tunnel"].each do |k, v|
        if not v 
            params[:"tunnel"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tunnel') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s"
    a10_name = new_resource.a10_name
    ip = new_resource.ip
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ifnum = new_resource.ifnum
    load_interval = new_resource.load_interval
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name
    speed = new_resource.speed
    uuid = new_resource.uuid

    params = { "tunnel": {"name": a10_name,
        "ip": ip,
        "user-tag": user_tag,
        "mtu": mtu,
        "ifnum": ifnum,
        "load-interval": load_interval,
        "ipv6": ipv6,
        "action": a10_action,
        "speed": speed,
        "uuid": uuid,} }

    params[:"tunnel"].each do |k, v|
        if not v
            params[:"tunnel"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tunnel"].each do |k, v|
        if v != params[:"tunnel"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tunnel') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tunnel') do
            client.delete(url)
        end
    end
end