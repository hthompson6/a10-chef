resource_name :a10_router_bgp_address_family_ipv6_neighbor_ipv4_neighbor

property :a10_name, String, name_property: true
property :maximum_prefix, Integer
property :neighbor_prefix_lists, Array
property :allowas_in_count, Integer
property :peer_group_name, String
property :send_community_val, ['both','none','standard','extended']
property :neighbor_ipv4, String,required: true
property :inbound, [true, false]
property :next_hop_self, [true, false]
property :maximum_prefix_thres, Integer
property :route_map, String
property :uuid, String
property :weight, Integer
property :unsuppress_map, String
property :default_originate, [true, false]
property :activate, [true, false]
property :remove_private_as, [true, false]
property :prefix_list_direction, ['both','receive','send']
property :allowas_in, [true, false]
property :neighbor_route_map_lists, Array
property :neighbor_filter_lists, Array
property :distribute_lists, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv4-neighbor/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    peer_group_name = new_resource.peer_group_name
    send_community_val = new_resource.send_community_val
    neighbor_ipv4 = new_resource.neighbor_ipv4
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    uuid = new_resource.uuid
    weight = new_resource.weight
    unsuppress_map = new_resource.unsuppress_map
    default_originate = new_resource.default_originate
    activate = new_resource.activate
    remove_private_as = new_resource.remove_private_as
    prefix_list_direction = new_resource.prefix_list_direction
    allowas_in = new_resource.allowas_in
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    distribute_lists = new_resource.distribute_lists

    params = { "ipv4-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "peer-group-name": peer_group_name,
        "send-community-val": send_community_val,
        "neighbor-ipv4": neighbor_ipv4,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "uuid": uuid,
        "weight": weight,
        "unsuppress-map": unsuppress_map,
        "default-originate": default_originate,
        "activate": activate,
        "remove-private-as": remove_private_as,
        "prefix-list-direction": prefix_list_direction,
        "allowas-in": allowas_in,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "neighbor-filter-lists": neighbor_filter_lists,
        "distribute-lists": distribute_lists,} }

    params[:"ipv4-neighbor"].each do |k, v|
        if not v 
            params[:"ipv4-neighbor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4-neighbor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    peer_group_name = new_resource.peer_group_name
    send_community_val = new_resource.send_community_val
    neighbor_ipv4 = new_resource.neighbor_ipv4
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    uuid = new_resource.uuid
    weight = new_resource.weight
    unsuppress_map = new_resource.unsuppress_map
    default_originate = new_resource.default_originate
    activate = new_resource.activate
    remove_private_as = new_resource.remove_private_as
    prefix_list_direction = new_resource.prefix_list_direction
    allowas_in = new_resource.allowas_in
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    distribute_lists = new_resource.distribute_lists

    params = { "ipv4-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "peer-group-name": peer_group_name,
        "send-community-val": send_community_val,
        "neighbor-ipv4": neighbor_ipv4,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "uuid": uuid,
        "weight": weight,
        "unsuppress-map": unsuppress_map,
        "default-originate": default_originate,
        "activate": activate,
        "remove-private-as": remove_private_as,
        "prefix-list-direction": prefix_list_direction,
        "allowas-in": allowas_in,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "neighbor-filter-lists": neighbor_filter_lists,
        "distribute-lists": distribute_lists,} }

    params[:"ipv4-neighbor"].each do |k, v|
        if not v
            params[:"ipv4-neighbor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4-neighbor"].each do |k, v|
        if v != params[:"ipv4-neighbor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4-neighbor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4-neighbor') do
            client.delete(url)
        end
    end
end