resource_name :a10_cgnv6_port_list

property :a10_name, String, name_property: true
property :port_config, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/port-list/"
    get_url = "/axapi/v3/cgnv6/port-list/%<name>s"
    port_config = new_resource.port_config
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "port-list": {"port-config": port_config,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"port-list"].each do |k, v|
        if not v 
            params[:"port-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/port-list/%<name>s"
    port_config = new_resource.port_config
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "port-list": {"port-config": port_config,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"port-list"].each do |k, v|
        if not v
            params[:"port-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port-list"].each do |k, v|
        if v != params[:"port-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/port-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port-list') do
            client.delete(url)
        end
    end
end