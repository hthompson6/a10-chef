resource_name :a10_cgnv6_lsn_rule_list_domain_ip

property :a10_name, String, name_property: true
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/"
    get_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-ip"
    sampling_enable = new_resource.sampling_enable

    params = { "domain-ip": {"sampling-enable": sampling_enable,} }

    params[:"domain-ip"].each do |k, v|
        if not v 
            params[:"domain-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-ip"
    sampling_enable = new_resource.sampling_enable

    params = { "domain-ip": {"sampling-enable": sampling_enable,} }

    params[:"domain-ip"].each do |k, v|
        if not v
            params[:"domain-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain-ip"].each do |k, v|
        if v != params[:"domain-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s/domain-ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain-ip') do
            client.delete(url)
        end
    end
end