resource_name :a10_router_bgp_address_family_ipv6

property :a10_name, String, name_property: true
property :distance, Hash
property :redistribute, Hash
property :aggregate_address_list, Array
property :originate, [true, false]
property :maximum_paths_value, Integer
property :bgp, Hash
property :auto_summary, [true, false]
property :synchronization, [true, false]
property :neighbor, Hash
property :uuid, String
property :network, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6"
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    aggregate_address_list = new_resource.aggregate_address_list
    originate = new_resource.originate
    maximum_paths_value = new_resource.maximum_paths_value
    bgp = new_resource.bgp
    auto_summary = new_resource.auto_summary
    synchronization = new_resource.synchronization
    neighbor = new_resource.neighbor
    uuid = new_resource.uuid
    network = new_resource.network

    params = { "ipv6": {"distance": distance,
        "redistribute": redistribute,
        "aggregate-address-list": aggregate_address_list,
        "originate": originate,
        "maximum-paths-value": maximum_paths_value,
        "bgp": bgp,
        "auto-summary": auto_summary,
        "synchronization": synchronization,
        "neighbor": neighbor,
        "uuid": uuid,
        "network": network,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6"
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    aggregate_address_list = new_resource.aggregate_address_list
    originate = new_resource.originate
    maximum_paths_value = new_resource.maximum_paths_value
    bgp = new_resource.bgp
    auto_summary = new_resource.auto_summary
    synchronization = new_resource.synchronization
    neighbor = new_resource.neighbor
    uuid = new_resource.uuid
    network = new_resource.network

    params = { "ipv6": {"distance": distance,
        "redistribute": redistribute,
        "aggregate-address-list": aggregate_address_list,
        "originate": originate,
        "maximum-paths-value": maximum_paths_value,
        "bgp": bgp,
        "auto-summary": auto_summary,
        "synchronization": synchronization,
        "neighbor": neighbor,
        "uuid": uuid,
        "network": network,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end