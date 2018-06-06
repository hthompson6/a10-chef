resource_name :a10_cgnv6_map_translation_domain_default_mapping_rule

property :a10_name, String, name_property: true
property :rule_ipv6_prefix, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/"
    get_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/default-mapping-rule"
    rule_ipv6_prefix = new_resource.rule_ipv6_prefix
    uuid = new_resource.uuid

    params = { "default-mapping-rule": {"rule-ipv6-prefix": rule_ipv6_prefix,
        "uuid": uuid,} }

    params[:"default-mapping-rule"].each do |k, v|
        if not v 
            params[:"default-mapping-rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating default-mapping-rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/default-mapping-rule"
    rule_ipv6_prefix = new_resource.rule_ipv6_prefix
    uuid = new_resource.uuid

    params = { "default-mapping-rule": {"rule-ipv6-prefix": rule_ipv6_prefix,
        "uuid": uuid,} }

    params[:"default-mapping-rule"].each do |k, v|
        if not v
            params[:"default-mapping-rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["default-mapping-rule"].each do |k, v|
        if v != params[:"default-mapping-rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating default-mapping-rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/default-mapping-rule"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default-mapping-rule') do
            client.delete(url)
        end
    end
end