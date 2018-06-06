resource_name :a10_debug_hm

property :a10_name, String, name_property: true
property :level, Integer,required: true
property :pin_uid, Integer
property :uuid, String
property :method_type, ['icmp','tcp','udp','ftp','http','snmp','smtp','dns','dns-tcp','pop3','imap','sip','sip-tcp','radius','ldap','rtsp','kerberos-kdc','database','external','https','ntp','compound']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/hm/"
    get_url = "/axapi/v3/debug/hm/%<level>s"
    level = new_resource.level
    pin_uid = new_resource.pin_uid
    uuid = new_resource.uuid
    method_type = new_resource.method_type

    params = { "hm": {"level": level,
        "pin-uid": pin_uid,
        "uuid": uuid,
        "method-type": method_type,} }

    params[:"hm"].each do |k, v|
        if not v 
            params[:"hm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating hm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/hm/%<level>s"
    level = new_resource.level
    pin_uid = new_resource.pin_uid
    uuid = new_resource.uuid
    method_type = new_resource.method_type

    params = { "hm": {"level": level,
        "pin-uid": pin_uid,
        "uuid": uuid,
        "method-type": method_type,} }

    params[:"hm"].each do |k, v|
        if not v
            params[:"hm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["hm"].each do |k, v|
        if v != params[:"hm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating hm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/hm/%<level>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting hm') do
            client.delete(url)
        end
    end
end