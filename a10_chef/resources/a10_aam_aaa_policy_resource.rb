resource_name :a10_aam_aaa_policy

property :a10_name, String, name_property: true
property :uuid, String
property :aaa_rule_list, Array
property :sampling_enable, Array
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/aaa-policy/"
    get_url = "/axapi/v3/aam/aaa-policy/%<name>s"
    uuid = new_resource.uuid
    aaa_rule_list = new_resource.aaa_rule_list
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "aaa-policy": {"uuid": uuid,
        "aaa-rule-list": aaa_rule_list,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"aaa-policy"].each do |k, v|
        if not v 
            params[:"aaa-policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating aaa-policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/aaa-policy/%<name>s"
    uuid = new_resource.uuid
    aaa_rule_list = new_resource.aaa_rule_list
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "aaa-policy": {"uuid": uuid,
        "aaa-rule-list": aaa_rule_list,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"aaa-policy"].each do |k, v|
        if not v
            params[:"aaa-policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["aaa-policy"].each do |k, v|
        if v != params[:"aaa-policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating aaa-policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/aaa-policy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting aaa-policy') do
            client.delete(url)
        end
    end
end