resource_name :a10_cgnv6_map_translation_domain_basic_mapping_rule_prefix_rule

property :a10_name, String, name_property: true
property :ipv4_netmask, String
property :rule_ipv4_prefix, String
property :user_tag, String
property :rule_ipv6_prefix, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule/prefix-rule/"
    get_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule/prefix-rule/%<name>s"
    a10_name = new_resource.a10_name
    ipv4_netmask = new_resource.ipv4_netmask
    rule_ipv4_prefix = new_resource.rule_ipv4_prefix
    user_tag = new_resource.user_tag
    rule_ipv6_prefix = new_resource.rule_ipv6_prefix
    uuid = new_resource.uuid

    params = { "prefix-rule": {"name": a10_name,
        "ipv4-netmask": ipv4_netmask,
        "rule-ipv4-prefix": rule_ipv4_prefix,
        "user-tag": user_tag,
        "rule-ipv6-prefix": rule_ipv6_prefix,
        "uuid": uuid,} }

    params[:"prefix-rule"].each do |k, v|
        if not v 
            params[:"prefix-rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating prefix-rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule/prefix-rule/%<name>s"
    a10_name = new_resource.a10_name
    ipv4_netmask = new_resource.ipv4_netmask
    rule_ipv4_prefix = new_resource.rule_ipv4_prefix
    user_tag = new_resource.user_tag
    rule_ipv6_prefix = new_resource.rule_ipv6_prefix
    uuid = new_resource.uuid

    params = { "prefix-rule": {"name": a10_name,
        "ipv4-netmask": ipv4_netmask,
        "rule-ipv4-prefix": rule_ipv4_prefix,
        "user-tag": user_tag,
        "rule-ipv6-prefix": rule_ipv6_prefix,
        "uuid": uuid,} }

    params[:"prefix-rule"].each do |k, v|
        if not v
            params[:"prefix-rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["prefix-rule"].each do |k, v|
        if v != params[:"prefix-rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating prefix-rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule/prefix-rule/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting prefix-rule') do
            client.delete(url)
        end
    end
end