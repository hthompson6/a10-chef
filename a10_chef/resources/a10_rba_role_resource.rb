resource_name :a10_rba_role

property :a10_name, String, name_property: true
property :default_privilege, ['no-access','read','write']
property :user_tag, String
property :rule_list, Array
property :partition_only, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rba/role/"
    get_url = "/axapi/v3/rba/role/%<name>s"
    default_privilege = new_resource.default_privilege
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    rule_list = new_resource.rule_list
    partition_only = new_resource.partition_only
    uuid = new_resource.uuid

    params = { "role": {"default-privilege": default_privilege,
        "name": a10_name,
        "user-tag": user_tag,
        "rule-list": rule_list,
        "partition-only": partition_only,
        "uuid": uuid,} }

    params[:"role"].each do |k, v|
        if not v 
            params[:"role"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating role') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/role/%<name>s"
    default_privilege = new_resource.default_privilege
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    rule_list = new_resource.rule_list
    partition_only = new_resource.partition_only
    uuid = new_resource.uuid

    params = { "role": {"default-privilege": default_privilege,
        "name": a10_name,
        "user-tag": user_tag,
        "rule-list": rule_list,
        "partition-only": partition_only,
        "uuid": uuid,} }

    params[:"role"].each do |k, v|
        if not v
            params[:"role"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["role"].each do |k, v|
        if v != params[:"role"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating role') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rba/role/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting role') do
            client.delete(url)
        end
    end
end