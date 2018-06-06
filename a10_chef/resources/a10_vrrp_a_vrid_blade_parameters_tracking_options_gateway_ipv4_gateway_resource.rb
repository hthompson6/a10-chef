resource_name :a10_vrrp_a_vrid_blade_parameters_tracking_options_gateway_ipv4_gateway

property :a10_name, String, name_property: true
property :uuid, String
property :ip_address, String,required: true
property :priority_cost, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options/gateway/ipv4-gateway/"
    get_url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options/gateway/ipv4-gateway/%<ip-address>s"
    uuid = new_resource.uuid
    ip_address = new_resource.ip_address
    priority_cost = new_resource.priority_cost

    params = { "ipv4-gateway": {"uuid": uuid,
        "ip-address": ip_address,
        "priority-cost": priority_cost,} }

    params[:"ipv4-gateway"].each do |k, v|
        if not v 
            params[:"ipv4-gateway"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4-gateway') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options/gateway/ipv4-gateway/%<ip-address>s"
    uuid = new_resource.uuid
    ip_address = new_resource.ip_address
    priority_cost = new_resource.priority_cost

    params = { "ipv4-gateway": {"uuid": uuid,
        "ip-address": ip_address,
        "priority-cost": priority_cost,} }

    params[:"ipv4-gateway"].each do |k, v|
        if not v
            params[:"ipv4-gateway"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4-gateway"].each do |k, v|
        if v != params[:"ipv4-gateway"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4-gateway') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/vrid/%<vrid-val>s/blade-parameters/tracking-options/gateway/ipv4-gateway/%<ip-address>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4-gateway') do
            client.delete(url)
        end
    end
end