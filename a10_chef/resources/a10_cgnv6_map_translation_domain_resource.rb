resource_name :a10_cgnv6_map_translation_domain

property :a10_name, String, name_property: true
property :default_mapping_rule, Hash
property :uuid, String
property :user_tag, String
property :mtu, Integer
property :sampling_enable, Array
property :tcp, Hash
property :health_check_gateway, Hash
property :basic_mapping_rule, Hash
property :description, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/domain/"
    get_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s"
    default_mapping_rule = new_resource.default_mapping_rule
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    sampling_enable = new_resource.sampling_enable
    tcp = new_resource.tcp
    health_check_gateway = new_resource.health_check_gateway
    basic_mapping_rule = new_resource.basic_mapping_rule
    description = new_resource.description

    params = { "domain": {"default-mapping-rule": default_mapping_rule,
        "uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "mtu": mtu,
        "sampling-enable": sampling_enable,
        "tcp": tcp,
        "health-check-gateway": health_check_gateway,
        "basic-mapping-rule": basic_mapping_rule,
        "description": description,} }

    params[:"domain"].each do |k, v|
        if not v 
            params[:"domain"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s"
    default_mapping_rule = new_resource.default_mapping_rule
    uuid = new_resource.uuid
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    sampling_enable = new_resource.sampling_enable
    tcp = new_resource.tcp
    health_check_gateway = new_resource.health_check_gateway
    basic_mapping_rule = new_resource.basic_mapping_rule
    description = new_resource.description

    params = { "domain": {"default-mapping-rule": default_mapping_rule,
        "uuid": uuid,
        "name": a10_name,
        "user-tag": user_tag,
        "mtu": mtu,
        "sampling-enable": sampling_enable,
        "tcp": tcp,
        "health-check-gateway": health_check_gateway,
        "basic-mapping-rule": basic_mapping_rule,
        "description": description,} }

    params[:"domain"].each do |k, v|
        if not v
            params[:"domain"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain"].each do |k, v|
        if v != params[:"domain"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain') do
            client.delete(url)
        end
    end
end