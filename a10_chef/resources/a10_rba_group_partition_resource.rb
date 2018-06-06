resource_name :a10_rba_group_partition

property :a10_name, String, name_property: true
property :partition_name, String,required: true
property :role_list, Array
property :uuid, String
property :user_tag, String
property :rule_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rba/group/%<name>s/partition/"
    get_url = "/axapi/v3/rba/group/%<name>s/partition/%<partition-name>s"
    partition_name = new_resource.partition_name
    role_list = new_resource.role_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    rule_list = new_resource.rule_list

    params = { "partition": {"partition-name": partition_name,
        "role-list": role_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "rule-list": rule_list,} }

    params[:"partition"].each do |k, v|
        if not v 
            params[:"partition"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating partition') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/group/%<name>s/partition/%<partition-name>s"
    partition_name = new_resource.partition_name
    role_list = new_resource.role_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    rule_list = new_resource.rule_list

    params = { "partition": {"partition-name": partition_name,
        "role-list": role_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "rule-list": rule_list,} }

    params[:"partition"].each do |k, v|
        if not v
            params[:"partition"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["partition"].each do |k, v|
        if v != params[:"partition"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating partition') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/group/%<name>s/partition/%<partition-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting partition') do
            client.delete(url)
        end
    end
end