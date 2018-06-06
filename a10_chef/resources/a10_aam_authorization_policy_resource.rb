resource_name :a10_aam_authorization_policy

property :a10_name, String, name_property: true
property :user_tag, String
property :server, String
property :service_group, String
property :attribute_list, Array
property :extended_filter, String
property :attribute_rule, String
property :forward_policy_authorize_only, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authorization/policy/"
    get_url = "/axapi/v3/aam/authorization/policy/%<name>s"
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    server = new_resource.server
    service_group = new_resource.service_group
    attribute_list = new_resource.attribute_list
    extended_filter = new_resource.extended_filter
    attribute_rule = new_resource.attribute_rule
    forward_policy_authorize_only = new_resource.forward_policy_authorize_only
    uuid = new_resource.uuid

    params = { "policy": {"name": a10_name,
        "user-tag": user_tag,
        "server": server,
        "service-group": service_group,
        "attribute-list": attribute_list,
        "extended-filter": extended_filter,
        "attribute-rule": attribute_rule,
        "forward-policy-authorize-only": forward_policy_authorize_only,
        "uuid": uuid,} }

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
    url = "/axapi/v3/aam/authorization/policy/%<name>s"
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    server = new_resource.server
    service_group = new_resource.service_group
    attribute_list = new_resource.attribute_list
    extended_filter = new_resource.extended_filter
    attribute_rule = new_resource.attribute_rule
    forward_policy_authorize_only = new_resource.forward_policy_authorize_only
    uuid = new_resource.uuid

    params = { "policy": {"name": a10_name,
        "user-tag": user_tag,
        "server": server,
        "service-group": service_group,
        "attribute-list": attribute_list,
        "extended-filter": extended_filter,
        "attribute-rule": attribute_rule,
        "forward-policy-authorize-only": forward_policy_authorize_only,
        "uuid": uuid,} }

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
    url = "/axapi/v3/aam/authorization/policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting policy') do
            client.delete(url)
        end
    end
end