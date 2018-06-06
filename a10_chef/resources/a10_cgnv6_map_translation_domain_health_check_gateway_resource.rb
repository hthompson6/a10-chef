resource_name :a10_cgnv6_map_translation_domain_health_check_gateway

property :a10_name, String, name_property: true
property :ipv6_address_list, Array
property :address_list, Array
property :withdraw_route, ['all-link-failure','any-link-failure']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/"
    get_url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/health-check-gateway"
    ipv6_address_list = new_resource.ipv6_address_list
    address_list = new_resource.address_list
    withdraw_route = new_resource.withdraw_route
    uuid = new_resource.uuid

    params = { "health-check-gateway": {"ipv6-address-list": ipv6_address_list,
        "address-list": address_list,
        "withdraw-route": withdraw_route,
        "uuid": uuid,} }

    params[:"health-check-gateway"].each do |k, v|
        if not v 
            params[:"health-check-gateway"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating health-check-gateway') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/health-check-gateway"
    ipv6_address_list = new_resource.ipv6_address_list
    address_list = new_resource.address_list
    withdraw_route = new_resource.withdraw_route
    uuid = new_resource.uuid

    params = { "health-check-gateway": {"ipv6-address-list": ipv6_address_list,
        "address-list": address_list,
        "withdraw-route": withdraw_route,
        "uuid": uuid,} }

    params[:"health-check-gateway"].each do |k, v|
        if not v
            params[:"health-check-gateway"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["health-check-gateway"].each do |k, v|
        if v != params[:"health-check-gateway"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating health-check-gateway') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/domain/%<name>s/health-check-gateway"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting health-check-gateway') do
            client.delete(url)
        end
    end
end