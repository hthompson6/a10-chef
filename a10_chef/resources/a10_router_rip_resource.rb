resource_name :a10_router_rip

property :a10_name, String, name_property: true
property :default_metric, Integer
property :route_cfg, Array
property :cisco_metric_behavior, ['enable','disable']
property :uuid, String
property :rip_maximum_prefix_cfg, Hash
property :offset_list, Hash
property :passive_interface_list, Array
property :redistribute, Hash
property :neighbor, Array
property :network_interface_list_cfg, Array
property :recv_buffer_size, Integer
property :timers, Hash
property :version, Integer
property :default_information, ['originate']
property :distribute_list, Hash
property :distance_list_cfg, Array
property :network_addresses, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/"
    get_url = "/axapi/v3/router/rip"
    default_metric = new_resource.default_metric
    route_cfg = new_resource.route_cfg
    cisco_metric_behavior = new_resource.cisco_metric_behavior
    uuid = new_resource.uuid
    rip_maximum_prefix_cfg = new_resource.rip_maximum_prefix_cfg
    offset_list = new_resource.offset_list
    passive_interface_list = new_resource.passive_interface_list
    redistribute = new_resource.redistribute
    neighbor = new_resource.neighbor
    network_interface_list_cfg = new_resource.network_interface_list_cfg
    recv_buffer_size = new_resource.recv_buffer_size
    timers = new_resource.timers
    version = new_resource.version
    default_information = new_resource.default_information
    distribute_list = new_resource.distribute_list
    distance_list_cfg = new_resource.distance_list_cfg
    network_addresses = new_resource.network_addresses

    params = { "rip": {"default-metric": default_metric,
        "route-cfg": route_cfg,
        "cisco-metric-behavior": cisco_metric_behavior,
        "uuid": uuid,
        "rip-maximum-prefix-cfg": rip_maximum_prefix_cfg,
        "offset-list": offset_list,
        "passive-interface-list": passive_interface_list,
        "redistribute": redistribute,
        "neighbor": neighbor,
        "network-interface-list-cfg": network_interface_list_cfg,
        "recv-buffer-size": recv_buffer_size,
        "timers": timers,
        "version": version,
        "default-information": default_information,
        "distribute-list": distribute_list,
        "distance-list-cfg": distance_list_cfg,
        "network-addresses": network_addresses,} }

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
    url = "/axapi/v3/router/rip"
    default_metric = new_resource.default_metric
    route_cfg = new_resource.route_cfg
    cisco_metric_behavior = new_resource.cisco_metric_behavior
    uuid = new_resource.uuid
    rip_maximum_prefix_cfg = new_resource.rip_maximum_prefix_cfg
    offset_list = new_resource.offset_list
    passive_interface_list = new_resource.passive_interface_list
    redistribute = new_resource.redistribute
    neighbor = new_resource.neighbor
    network_interface_list_cfg = new_resource.network_interface_list_cfg
    recv_buffer_size = new_resource.recv_buffer_size
    timers = new_resource.timers
    version = new_resource.version
    default_information = new_resource.default_information
    distribute_list = new_resource.distribute_list
    distance_list_cfg = new_resource.distance_list_cfg
    network_addresses = new_resource.network_addresses

    params = { "rip": {"default-metric": default_metric,
        "route-cfg": route_cfg,
        "cisco-metric-behavior": cisco_metric_behavior,
        "uuid": uuid,
        "rip-maximum-prefix-cfg": rip_maximum_prefix_cfg,
        "offset-list": offset_list,
        "passive-interface-list": passive_interface_list,
        "redistribute": redistribute,
        "neighbor": neighbor,
        "network-interface-list-cfg": network_interface_list_cfg,
        "recv-buffer-size": recv_buffer_size,
        "timers": timers,
        "version": version,
        "default-information": default_information,
        "distribute-list": distribute_list,
        "distance-list-cfg": distance_list_cfg,
        "network-addresses": network_addresses,} }

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
    url = "/axapi/v3/router/rip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rip') do
            client.delete(url)
        end
    end
end