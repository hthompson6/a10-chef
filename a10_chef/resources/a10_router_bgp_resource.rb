resource_name :a10_router_bgp

property :a10_name, String, name_property: true
property :redistribute, Hash
property :as_number, Integer,required: true
property :aggregate_address_list, Array
property :originate, [true, false]
property :maximum_paths_value, Integer
property :user_tag, String
property :bgp, Hash
property :auto_summary, [true, false]
property :synchronization, [true, false]
property :timers, Hash
property :neighbor, Hash
property :distance_list, Array
property :uuid, String
property :address_family, Hash
property :network, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s"
    redistribute = new_resource.redistribute
    as_number = new_resource.as_number
    aggregate_address_list = new_resource.aggregate_address_list
    originate = new_resource.originate
    maximum_paths_value = new_resource.maximum_paths_value
    user_tag = new_resource.user_tag
    bgp = new_resource.bgp
    auto_summary = new_resource.auto_summary
    synchronization = new_resource.synchronization
    timers = new_resource.timers
    neighbor = new_resource.neighbor
    distance_list = new_resource.distance_list
    uuid = new_resource.uuid
    address_family = new_resource.address_family
    network = new_resource.network

    params = { "bgp": {"redistribute": redistribute,
        "as-number": as_number,
        "aggregate-address-list": aggregate_address_list,
        "originate": originate,
        "maximum-paths-value": maximum_paths_value,
        "user-tag": user_tag,
        "bgp": bgp,
        "auto-summary": auto_summary,
        "synchronization": synchronization,
        "timers": timers,
        "neighbor": neighbor,
        "distance-list": distance_list,
        "uuid": uuid,
        "address-family": address_family,
        "network": network,} }

    params[:"bgp"].each do |k, v|
        if not v 
            params[:"bgp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bgp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s"
    redistribute = new_resource.redistribute
    as_number = new_resource.as_number
    aggregate_address_list = new_resource.aggregate_address_list
    originate = new_resource.originate
    maximum_paths_value = new_resource.maximum_paths_value
    user_tag = new_resource.user_tag
    bgp = new_resource.bgp
    auto_summary = new_resource.auto_summary
    synchronization = new_resource.synchronization
    timers = new_resource.timers
    neighbor = new_resource.neighbor
    distance_list = new_resource.distance_list
    uuid = new_resource.uuid
    address_family = new_resource.address_family
    network = new_resource.network

    params = { "bgp": {"redistribute": redistribute,
        "as-number": as_number,
        "aggregate-address-list": aggregate_address_list,
        "originate": originate,
        "maximum-paths-value": maximum_paths_value,
        "user-tag": user_tag,
        "bgp": bgp,
        "auto-summary": auto_summary,
        "synchronization": synchronization,
        "timers": timers,
        "neighbor": neighbor,
        "distance-list": distance_list,
        "uuid": uuid,
        "address-family": address_family,
        "network": network,} }

    params[:"bgp"].each do |k, v|
        if not v
            params[:"bgp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bgp"].each do |k, v|
        if v != params[:"bgp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bgp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bgp') do
            client.delete(url)
        end
    end
end