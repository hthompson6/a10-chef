resource_name :a10_ip_list

property :a10_name, String, name_property: true
property :ipv6_config, Array
property :user_tag, String
property :ipv4_config, Array
property :ipv6_prefix_config, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip-list/"
    get_url = "/axapi/v3/ip-list/%<name>s"
    a10_name = new_resource.a10_name
    ipv6_config = new_resource.ipv6_config
    user_tag = new_resource.user_tag
    ipv4_config = new_resource.ipv4_config
    ipv6_prefix_config = new_resource.ipv6_prefix_config
    uuid = new_resource.uuid

    params = { "ip-list": {"name": a10_name,
        "ipv6-config": ipv6_config,
        "user-tag": user_tag,
        "ipv4-config": ipv4_config,
        "ipv6-prefix-config": ipv6_prefix_config,
        "uuid": uuid,} }

    params[:"ip-list"].each do |k, v|
        if not v 
            params[:"ip-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip-list/%<name>s"
    a10_name = new_resource.a10_name
    ipv6_config = new_resource.ipv6_config
    user_tag = new_resource.user_tag
    ipv4_config = new_resource.ipv4_config
    ipv6_prefix_config = new_resource.ipv6_prefix_config
    uuid = new_resource.uuid

    params = { "ip-list": {"name": a10_name,
        "ipv6-config": ipv6_config,
        "user-tag": user_tag,
        "ipv4-config": ipv4_config,
        "ipv6-prefix-config": ipv6_prefix_config,
        "uuid": uuid,} }

    params[:"ip-list"].each do |k, v|
        if not v
            params[:"ip-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip-list"].each do |k, v|
        if v != params[:"ip-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip-list') do
            client.delete(url)
        end
    end
end