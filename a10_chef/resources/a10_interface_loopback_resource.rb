resource_name :a10_interface_loopback

property :a10_name, String, name_property: true
property :isis, Hash
property :uuid, String
property :snmp_server, Hash
property :ip, Hash
property :user_tag, String
property :ifnum, Integer,required: true
property :ipv6, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/loopback/"
    get_url = "/axapi/v3/interface/loopback/%<ifnum>s"
    isis = new_resource.isis
    uuid = new_resource.uuid
    snmp_server = new_resource.snmp_server
    ip = new_resource.ip
    user_tag = new_resource.user_tag
    ifnum = new_resource.ifnum
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name

    params = { "loopback": {"isis": isis,
        "uuid": uuid,
        "snmp-server": snmp_server,
        "ip": ip,
        "user-tag": user_tag,
        "ifnum": ifnum,
        "ipv6": ipv6,
        "name": a10_name,} }

    params[:"loopback"].each do |k, v|
        if not v 
            params[:"loopback"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating loopback') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s"
    isis = new_resource.isis
    uuid = new_resource.uuid
    snmp_server = new_resource.snmp_server
    ip = new_resource.ip
    user_tag = new_resource.user_tag
    ifnum = new_resource.ifnum
    ipv6 = new_resource.ipv6
    a10_name = new_resource.a10_name

    params = { "loopback": {"isis": isis,
        "uuid": uuid,
        "snmp-server": snmp_server,
        "ip": ip,
        "user-tag": user_tag,
        "ifnum": ifnum,
        "ipv6": ipv6,
        "name": a10_name,} }

    params[:"loopback"].each do |k, v|
        if not v
            params[:"loopback"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["loopback"].each do |k, v|
        if v != params[:"loopback"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating loopback') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting loopback') do
            client.delete(url)
        end
    end
end