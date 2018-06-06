resource_name :a10_cgnv6_lsn_rule_list_default

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :uuid, String
property :rule_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/"
    get_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/default"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    rule_cfg = new_resource.rule_cfg

    params = { "default": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "rule-cfg": rule_cfg,} }

    params[:"default"].each do |k, v|
        if not v 
            params[:"default"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating default') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/default"
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    rule_cfg = new_resource.rule_cfg

    params = { "default": {"sampling-enable": sampling_enable,
        "uuid": uuid,
        "rule-cfg": rule_cfg,} }

    params[:"default"].each do |k, v|
        if not v
            params[:"default"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["default"].each do |k, v|
        if v != params[:"default"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating default') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/default"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default') do
            client.delete(url)
        end
    end
end