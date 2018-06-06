resource_name :a10_cgnv6_lsn_rule_list_domain_name

property :a10_name, String, name_property: true
property :name_domain, String,required: true
property :sampling_enable, Array
property :uuid, String
property :user_tag, String
property :rule_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-name/"
    get_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-name/%<name-domain>s"
    name_domain = new_resource.name_domain
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    rule_cfg = new_resource.rule_cfg

    params = { "domain-name": {"name-domain": name_domain,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "user-tag": user_tag,
        "rule-cfg": rule_cfg,} }

    params[:"domain-name"].each do |k, v|
        if not v 
            params[:"domain-name"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain-name') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-name/%<name-domain>s"
    name_domain = new_resource.name_domain
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    rule_cfg = new_resource.rule_cfg

    params = { "domain-name": {"name-domain": name_domain,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "user-tag": user_tag,
        "rule-cfg": rule_cfg,} }

    params[:"domain-name"].each do |k, v|
        if not v
            params[:"domain-name"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain-name"].each do |k, v|
        if v != params[:"domain-name"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain-name') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-name/%<name-domain>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain-name') do
            client.delete(url)
        end
    end
end