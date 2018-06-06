resource_name :a10_router_ipv6_rip

property :a10_name, String, name_property: true
property :default_metric, Integer
property :recv_buffer_size, Integer
property :cisco_metric_behavior, ['enable','disable']
property :uuid, String
property :offset_list, Hash
property :route_map, Hash
property :passive_interface_list, Array
property :redistribute, Hash
property :route_cfg, Array
property :timers, Hash
property :aggregate_address_cfg, Array
property :default_information, ['originate']
property :ripng_neighbor, Hash
property :distribute_list, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ipv6/"
    get_url = "/axapi/v3/router/ipv6/rip"
    default_metric = new_resource.default_metric
    recv_buffer_size = new_resource.recv_buffer_size
    cisco_metric_behavior = new_resource.cisco_metric_behavior
    uuid = new_resource.uuid
    offset_list = new_resource.offset_list
    route_map = new_resource.route_map
    passive_interface_list = new_resource.passive_interface_list
    redistribute = new_resource.redistribute
    route_cfg = new_resource.route_cfg
    timers = new_resource.timers
    aggregate_address_cfg = new_resource.aggregate_address_cfg
    default_information = new_resource.default_information
    ripng_neighbor = new_resource.ripng_neighbor
    distribute_list = new_resource.distribute_list

    params = { "rip": {"default-metric": default_metric,
        "recv-buffer-size": recv_buffer_size,
        "cisco-metric-behavior": cisco_metric_behavior,
        "uuid": uuid,
        "offset-list": offset_list,
        "route-map": route_map,
        "passive-interface-list": passive_interface_list,
        "redistribute": redistribute,
        "route-cfg": route_cfg,
        "timers": timers,
        "aggregate-address-cfg": aggregate_address_cfg,
        "default-information": default_information,
        "ripng-neighbor": ripng_neighbor,
        "distribute-list": distribute_list,} }

    params[:"rip"].each do |k, v|
        if not v 
            params[:"rip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip"
    default_metric = new_resource.default_metric
    recv_buffer_size = new_resource.recv_buffer_size
    cisco_metric_behavior = new_resource.cisco_metric_behavior
    uuid = new_resource.uuid
    offset_list = new_resource.offset_list
    route_map = new_resource.route_map
    passive_interface_list = new_resource.passive_interface_list
    redistribute = new_resource.redistribute
    route_cfg = new_resource.route_cfg
    timers = new_resource.timers
    aggregate_address_cfg = new_resource.aggregate_address_cfg
    default_information = new_resource.default_information
    ripng_neighbor = new_resource.ripng_neighbor
    distribute_list = new_resource.distribute_list

    params = { "rip": {"default-metric": default_metric,
        "recv-buffer-size": recv_buffer_size,
        "cisco-metric-behavior": cisco_metric_behavior,
        "uuid": uuid,
        "offset-list": offset_list,
        "route-map": route_map,
        "passive-interface-list": passive_interface_list,
        "redistribute": redistribute,
        "route-cfg": route_cfg,
        "timers": timers,
        "aggregate-address-cfg": aggregate_address_cfg,
        "default-information": default_information,
        "ripng-neighbor": ripng_neighbor,
        "distribute-list": distribute_list,} }

    params[:"rip"].each do |k, v|
        if not v
            params[:"rip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rip"].each do |k, v|
        if v != params[:"rip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ipv6/rip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rip') do
            client.delete(url)
        end
    end
end