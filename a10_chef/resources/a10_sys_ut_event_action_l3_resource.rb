resource_name :a10_sys_ut_event_action_l3

property :a10_name, String, name_property: true
property :protocol, [true, false]
property :uuid, String
property :checksum, ['valid','invalid']
property :value, Integer
property :ip_list, Array
property :ttl, Integer
property :ntype, ['tcp','udp','icmp']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    value = new_resource.value
    ip_list = new_resource.ip_list
    ttl = new_resource.ttl
    ntype = new_resource.ntype

    params = { "l3": {"protocol": protocol,
        "uuid": uuid,
        "checksum": checksum,
        "value": value,
        "ip-list": ip_list,
        "ttl": ttl,
        "type": ntype,} }

    params[:"l3"].each do |k, v|
        if not v 
            params[:"l3"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating l3') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    value = new_resource.value
    ip_list = new_resource.ip_list
    ttl = new_resource.ttl
    ntype = new_resource.ntype

    params = { "l3": {"protocol": protocol,
        "uuid": uuid,
        "checksum": checksum,
        "value": value,
        "ip-list": ip_list,
        "ttl": ttl,
        "type": ntype,} }

    params[:"l3"].each do |k, v|
        if not v
            params[:"l3"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["l3"].each do |k, v|
        if v != params[:"l3"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating l3') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/l3"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting l3') do
            client.delete(url)
        end
    end
end