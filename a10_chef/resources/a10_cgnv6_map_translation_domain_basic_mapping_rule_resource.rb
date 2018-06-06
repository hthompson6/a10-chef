resource_name :a10_cgnv6_map_translation_domain_basic_mapping_rule

property :a10_name, String, name_property: true
property :rule_ipv4_address_port_settings, ['prefix-addr','single-addr','shared-addr']
property :port_start, Integer
property :uuid, String
property :share_ratio, Integer
property :prefix_rule_list, Array
property :ea_length, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/"
    get_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule"
    rule_ipv4_address_port_settings = new_resource.rule_ipv4_address_port_settings
    port_start = new_resource.port_start
    uuid = new_resource.uuid
    share_ratio = new_resource.share_ratio
    prefix_rule_list = new_resource.prefix_rule_list
    ea_length = new_resource.ea_length

    params = { "basic-mapping-rule": {"rule-ipv4-address-port-settings": rule_ipv4_address_port_settings,
        "port-start": port_start,
        "uuid": uuid,
        "share-ratio": share_ratio,
        "prefix-rule-list": prefix_rule_list,
        "ea-length": ea_length,} }

    params[:"basic-mapping-rule"].each do |k, v|
        if not v 
            params[:"basic-mapping-rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating basic-mapping-rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule"
    rule_ipv4_address_port_settings = new_resource.rule_ipv4_address_port_settings
    port_start = new_resource.port_start
    uuid = new_resource.uuid
    share_ratio = new_resource.share_ratio
    prefix_rule_list = new_resource.prefix_rule_list
    ea_length = new_resource.ea_length

    params = { "basic-mapping-rule": {"rule-ipv4-address-port-settings": rule_ipv4_address_port_settings,
        "port-start": port_start,
        "uuid": uuid,
        "share-ratio": share_ratio,
        "prefix-rule-list": prefix_rule_list,
        "ea-length": ea_length,} }

    params[:"basic-mapping-rule"].each do |k, v|
        if not v
            params[:"basic-mapping-rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["basic-mapping-rule"].each do |k, v|
        if v != params[:"basic-mapping-rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating basic-mapping-rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/basic-mapping-rule"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting basic-mapping-rule') do
            client.delete(url)
        end
    end
end