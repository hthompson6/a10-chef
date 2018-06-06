resource_name :a10_router_bgp_address_family_ipv6_neighbor_ipv6_neighbor

property :a10_name, String, name_property: true
property :maximum_prefix, Integer
property :neighbor_prefix_lists, Array
property :allowas_in_count, Integer
property :neighbor_ipv6, String,required: true
property :send_community_val, ['both','none','standard','extended']
property :inbound, [true, false]
property :next_hop_self, [true, false]
property :maximum_prefix_thres, Integer
property :route_map, String
property :peer_group_name, String
property :weight, Integer
property :unsuppress_map, String
property :prefix_list_direction, ['both','receive','send']
property :default_originate, [true, false]
property :activate, [true, false]
property :remove_private_as, [true, false]
property :distribute_lists, Array
property :allowas_in, [true, false]
property :neighbor_route_map_lists, Array
property :neighbor_filter_lists, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv6-neighbor/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv6-neighbor/%<neighbor-ipv6>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    neighbor_ipv6 = new_resource.neighbor_ipv6
    send_community_val = new_resource.send_community_val
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    peer_group_name = new_resource.peer_group_name
    weight = new_resource.weight
    unsuppress_map = new_resource.unsuppress_map
    prefix_list_direction = new_resource.prefix_list_direction
    default_originate = new_resource.default_originate
    activate = new_resource.activate
    remove_private_as = new_resource.remove_private_as
    distribute_lists = new_resource.distribute_lists
    allowas_in = new_resource.allowas_in
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    uuid = new_resource.uuid

    params = { "ipv6-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "neighbor-ipv6": neighbor_ipv6,
        "send-community-val": send_community_val,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "peer-group-name": peer_group_name,
        "weight": weight,
        "unsuppress-map": unsuppress_map,
        "prefix-list-direction": prefix_list_direction,
        "default-originate": default_originate,
        "activate": activate,
        "remove-private-as": remove_private_as,
        "distribute-lists": distribute_lists,
        "allowas-in": allowas_in,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "neighbor-filter-lists": neighbor_filter_lists,
        "uuid": uuid,} }

    params[:"ipv6-neighbor"].each do |k, v|
        if not v 
            params[:"ipv6-neighbor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6-neighbor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv6-neighbor/%<neighbor-ipv6>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    neighbor_ipv6 = new_resource.neighbor_ipv6
    send_community_val = new_resource.send_community_val
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    peer_group_name = new_resource.peer_group_name
    weight = new_resource.weight
    unsuppress_map = new_resource.unsuppress_map
    prefix_list_direction = new_resource.prefix_list_direction
    default_originate = new_resource.default_originate
    activate = new_resource.activate
    remove_private_as = new_resource.remove_private_as
    distribute_lists = new_resource.distribute_lists
    allowas_in = new_resource.allowas_in
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    uuid = new_resource.uuid

    params = { "ipv6-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "neighbor-ipv6": neighbor_ipv6,
        "send-community-val": send_community_val,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "peer-group-name": peer_group_name,
        "weight": weight,
        "unsuppress-map": unsuppress_map,
        "prefix-list-direction": prefix_list_direction,
        "default-originate": default_originate,
        "activate": activate,
        "remove-private-as": remove_private_as,
        "distribute-lists": distribute_lists,
        "allowas-in": allowas_in,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "neighbor-filter-lists": neighbor_filter_lists,
        "uuid": uuid,} }

    params[:"ipv6-neighbor"].each do |k, v|
        if not v
            params[:"ipv6-neighbor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6-neighbor"].each do |k, v|
        if v != params[:"ipv6-neighbor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6-neighbor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/ipv6-neighbor/%<neighbor-ipv6>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6-neighbor') do
            client.delete(url)
        end
    end
end