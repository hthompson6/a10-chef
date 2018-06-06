resource_name :a10_rule_set_rule_move_rule

property :a10_name, String, name_property: true
property :location, ['top','before','after','bottom']
property :target_rule, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s/"
    get_url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s/move-rule"
    location = new_resource.location
    target_rule = new_resource.target_rule

    params = { "move-rule": {"location": location,
        "target-rule": target_rule,} }

    params[:"move-rule"].each do |k, v|
        if not v 
            params[:"move-rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating move-rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s/move-rule"
    location = new_resource.location
    target_rule = new_resource.target_rule

    params = { "move-rule": {"location": location,
        "target-rule": target_rule,} }

    params[:"move-rule"].each do |k, v|
        if not v
            params[:"move-rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["move-rule"].each do |k, v|
        if v != params[:"move-rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating move-rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s/move-rule"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting move-rule') do
            client.delete(url)
        end
    end
end