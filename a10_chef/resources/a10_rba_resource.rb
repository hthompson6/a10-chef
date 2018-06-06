resource_name :a10_rba

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']
property :group_list, Array
property :user_list, Array
property :role_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/rba"
    a10_name = new_resource.a10_name
    group_list = new_resource.group_list
    user_list = new_resource.user_list
    role_list = new_resource.role_list
    uuid = new_resource.uuid

    params = { "rba": {"action": a10_action,
        "group-list": group_list,
        "user-list": user_list,
        "role-list": role_list,
        "uuid": uuid,} }

    params[:"rba"].each do |k, v|
        if not v 
            params[:"rba"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rba') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba"
    a10_name = new_resource.a10_name
    group_list = new_resource.group_list
    user_list = new_resource.user_list
    role_list = new_resource.role_list
    uuid = new_resource.uuid

    params = { "rba": {"action": a10_action,
        "group-list": group_list,
        "user-list": user_list,
        "role-list": role_list,
        "uuid": uuid,} }

    params[:"rba"].each do |k, v|
        if not v
            params[:"rba"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rba"].each do |k, v|
        if v != params[:"rba"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rba') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rba') do
            client.delete(url)
        end
    end
end