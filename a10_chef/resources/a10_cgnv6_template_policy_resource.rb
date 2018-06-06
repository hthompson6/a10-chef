resource_name :a10_cgnv6_template_policy

property :a10_name, String, name_property: true
property :uuid, String
property :user_tag, String
property :class_list, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/policy/"
    get_url = "/axapi/v3/cgnv6/template/policy/%<name>s"
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    class_list = new_resource.class_list

    params = { "policy": {"uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "class-list": class_list,} }

    params[:"policy"].each do |k, v|
        if not v 
            params[:"policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/policy/%<name>s"
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    class_list = new_resource.class_list

    params = { "policy": {"uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "class-list": class_list,} }

    params[:"policy"].each do |k, v|
        if not v
            params[:"policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["policy"].each do |k, v|
        if v != params[:"policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting policy') do
            client.delete(url)
        end
    end
end