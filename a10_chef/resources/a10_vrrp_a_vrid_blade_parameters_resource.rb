resource_name :a10_vrrp_a_vrid_blade_parameters

property :a10_name, String, name_property: true
property :priority, Integer
property :fail_over_policy_template, String
property :uuid, String
property :tracking_options, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/"
    get_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters"
    priority = new_resource.priority
    fail_over_policy_template = new_resource.fail_over_policy_template
    uuid = new_resource.uuid
    tracking_options = new_resource.tracking_options

    params = { "blade-parameters": {"priority": priority,
        "fail-over-policy-template": fail_over_policy_template,
        "uuid": uuid,
        "tracking-options": tracking_options,} }

    params[:"blade-parameters"].each do |k, v|
        if not v 
            params[:"blade-parameters"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating blade-parameters') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters"
    priority = new_resource.priority
    fail_over_policy_template = new_resource.fail_over_policy_template
    uuid = new_resource.uuid
    tracking_options = new_resource.tracking_options

    params = { "blade-parameters": {"priority": priority,
        "fail-over-policy-template": fail_over_policy_template,
        "uuid": uuid,
        "tracking-options": tracking_options,} }

    params[:"blade-parameters"].each do |k, v|
        if not v
            params[:"blade-parameters"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["blade-parameters"].each do |k, v|
        if v != params[:"blade-parameters"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating blade-parameters') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting blade-parameters') do
            client.delete(url)
        end
    end
end