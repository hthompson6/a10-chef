resource_name :a10_partition_group

property :a10_name, String, name_property: true
property :partition_group_name, String,required: true
property :member_list, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/partition-group/"
    get_url = "/axapi/v3/partition-group/%<partition-group-name>s"
    partition_group_name = new_resource.partition_group_name
    member_list = new_resource.member_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "partition-group": {"partition-group-name": partition_group_name,
        "member-list": member_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"partition-group"].each do |k, v|
        if not v 
            params[:"partition-group"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating partition-group') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/partition-group/%<partition-group-name>s"
    partition_group_name = new_resource.partition_group_name
    member_list = new_resource.member_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "partition-group": {"partition-group-name": partition_group_name,
        "member-list": member_list,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"partition-group"].each do |k, v|
        if not v
            params[:"partition-group"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["partition-group"].each do |k, v|
        if v != params[:"partition-group"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating partition-group') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/partition-group/%<partition-group-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting partition-group') do
            client.delete(url)
        end
    end
end