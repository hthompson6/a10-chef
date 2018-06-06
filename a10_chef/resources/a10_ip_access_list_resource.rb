resource_name :a10_ip_access_list

property :a10_name, String, name_property: true
property :rules, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/access-list/"
    get_url = "/axapi/v3/ip/access-list/%<name>s"
    rules = new_resource.rules
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "access-list": {"rules": rules,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"access-list"].each do |k, v|
        if not v 
            params[:"access-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating access-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/access-list/%<name>s"
    rules = new_resource.rules
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "access-list": {"rules": rules,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"access-list"].each do |k, v|
        if not v
            params[:"access-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["access-list"].each do |k, v|
        if v != params[:"access-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating access-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/access-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting access-list') do
            client.delete(url)
        end
    end
end