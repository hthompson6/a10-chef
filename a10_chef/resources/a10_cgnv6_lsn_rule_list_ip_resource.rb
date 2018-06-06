resource_name :a10_cgnv6_lsn_rule_list_ip

property :a10_name, String, name_property: true
property :ipv4_addr, String,required: true
property :rule_cfg, Array
property :sampling_enable, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/ip/"
    get_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/ip/%<ipv4-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    rule_cfg = new_resource.rule_cfg
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "ip": {"ipv4-addr": ipv4_addr,
        "rule-cfg": rule_cfg,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/ip/%<ipv4-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    rule_cfg = new_resource.rule_cfg
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "ip": {"ipv4-addr": ipv4_addr,
        "rule-cfg": rule_cfg,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/ip/%<ipv4-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end