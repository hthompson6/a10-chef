resource_name :a10_object_group_network

property :a10_name, String, name_property: true
property :description, String
property :rules, Array
property :user_tag, String
property :ip_version, ['v4','v6']
property :usage, ['acl','fw']
property :net_name, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/object-group/network/"
    get_url = "/axapi/v3/object-group/network/%<net-name>s"
    description = new_resource.description
    rules = new_resource.rules
    user_tag = new_resource.user_tag
    ip_version = new_resource.ip_version
    usage = new_resource.usage
    net_name = new_resource.net_name
    uuid = new_resource.uuid

    params = { "network": {"description": description,
        "rules": rules,
        "user-tag": user_tag,
        "ip-version": ip_version,
        "usage": usage,
        "net-name": net_name,
        "uuid": uuid,} }

    params[:"network"].each do |k, v|
        if not v 
            params[:"network"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating network') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/network/%<net-name>s"
    description = new_resource.description
    rules = new_resource.rules
    user_tag = new_resource.user_tag
    ip_version = new_resource.ip_version
    usage = new_resource.usage
    net_name = new_resource.net_name
    uuid = new_resource.uuid

    params = { "network": {"description": description,
        "rules": rules,
        "user-tag": user_tag,
        "ip-version": ip_version,
        "usage": usage,
        "net-name": net_name,
        "uuid": uuid,} }

    params[:"network"].each do |k, v|
        if not v
            params[:"network"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["network"].each do |k, v|
        if v != params[:"network"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating network') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/network/%<net-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting network') do
            client.delete(url)
        end
    end
end