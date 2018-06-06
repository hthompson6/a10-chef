resource_name :a10_fw_session_aging

property :a10_name, String, name_property: true
property :icmp_idle_timeout, Integer
property :udp, Hash
property :ip_idle_timeout, Integer
property :user_tag, String
property :tcp, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/session-aging/"
    get_url = "/axapi/v3/fw/session-aging/%<name>s"
    icmp_idle_timeout = new_resource.icmp_idle_timeout
    udp = new_resource.udp
    ip_idle_timeout = new_resource.ip_idle_timeout
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "session-aging": {"icmp-idle-timeout": icmp_idle_timeout,
        "udp": udp,
        "ip-idle-timeout": ip_idle_timeout,
        "name": a10_name,
        "user-tag": user_tag,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"session-aging"].each do |k, v|
        if not v 
            params[:"session-aging"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating session-aging') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/session-aging/%<name>s"
    icmp_idle_timeout = new_resource.icmp_idle_timeout
    udp = new_resource.udp
    ip_idle_timeout = new_resource.ip_idle_timeout
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    tcp = new_resource.tcp
    uuid = new_resource.uuid

    params = { "session-aging": {"icmp-idle-timeout": icmp_idle_timeout,
        "udp": udp,
        "ip-idle-timeout": ip_idle_timeout,
        "name": a10_name,
        "user-tag": user_tag,
        "tcp": tcp,
        "uuid": uuid,} }

    params[:"session-aging"].each do |k, v|
        if not v
            params[:"session-aging"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["session-aging"].each do |k, v|
        if v != params[:"session-aging"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating session-aging') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/session-aging/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting session-aging') do
            client.delete(url)
        end
    end
end