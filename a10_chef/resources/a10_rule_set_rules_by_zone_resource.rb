resource_name :a10_rule_set_rules_by_zone

property :a10_name, String, name_property: true
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rule-set/%<name>s/"
    get_url = "/axapi/v3/rule-set/%<name>s/rules-by-zone"
    sampling_enable = new_resource.sampling_enable

    params = { "rules-by-zone": {"sampling-enable": sampling_enable,} }

    params[:"rules-by-zone"].each do |k, v|
        if not v 
            params[:"rules-by-zone"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rules-by-zone') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rules-by-zone"
    sampling_enable = new_resource.sampling_enable

    params = { "rules-by-zone": {"sampling-enable": sampling_enable,} }

    params[:"rules-by-zone"].each do |k, v|
        if not v
            params[:"rules-by-zone"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rules-by-zone"].each do |k, v|
        if v != params[:"rules-by-zone"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rules-by-zone') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rules-by-zone"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rules-by-zone') do
            client.delete(url)
        end
    end
end