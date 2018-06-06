resource_name :a10_rba_user

property :a10_name, String, name_property: true
property :partition_list, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rba/user/"
    get_url = "/axapi/v3/rba/user/%<name>s"
    partition_list = new_resource.partition_list
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "user": {"partition-list": partition_list,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"user"].each do |k, v|
        if not v 
            params[:"user"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating user') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/user/%<name>s"
    partition_list = new_resource.partition_list
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "user": {"partition-list": partition_list,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"user"].each do |k, v|
        if not v
            params[:"user"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["user"].each do |k, v|
        if v != params[:"user"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating user') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/user/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting user') do
            client.delete(url)
        end
    end
end