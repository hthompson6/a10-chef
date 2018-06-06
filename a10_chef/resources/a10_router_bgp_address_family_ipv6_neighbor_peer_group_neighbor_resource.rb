resource_name :a10_router_bgp_address_family_ipv6_neighbor_peer_group_neighbor

property :a10_name, String, name_property: true
property :maximum_prefix, Integer
property :neighbor_prefix_lists, Array
property :activate, [true, false]
property :weight, Integer
property :send_community_val, ['both','none','standard','extended']
property :inbound, [true, false]
property :next_hop_self, [true, false]
property :maximum_prefix_thres, Integer
property :route_map, String
property :peer_group, String,required: true
property :remove_private_as, [true, false]
property :default_originate, [true, false]
property :allowas_in_count, Integer
property :distribute_lists, Array
property :prefix_list_direction, ['both','receive','send']
property :allowas_in, [true, false]
property :unsuppress_map, String
property :neighbor_filter_lists, Array
property :neighbor_route_map_lists, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/peer-group-neighbor/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/peer-group-neighbor/%<peer-group>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    activate = new_resource.activate
    weight = new_resource.weight
    send_community_val = new_resource.send_community_val
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    peer_group = new_resource.peer_group
    remove_private_as = new_resource.remove_private_as
    default_originate = new_resource.default_originate
    allowas_in_count = new_resource.allowas_in_count
    distribute_lists = new_resource.distribute_lists
    prefix_list_direction = new_resource.prefix_list_direction
    allowas_in = new_resource.allowas_in
    unsuppress_map = new_resource.unsuppress_map
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    uuid = new_resource.uuid

    params = { "peer-group-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "activate": activate,
        "weight": weight,
        "send-community-val": send_community_val,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "peer-group": peer_group,
        "remove-private-as": remove_private_as,
        "default-originate": default_originate,
        "allowas-in-count": allowas_in_count,
        "distribute-lists": distribute_lists,
        "prefix-list-direction": prefix_list_direction,
        "allowas-in": allowas_in,
        "unsuppress-map": unsuppress_map,
        "neighbor-filter-lists": neighbor_filter_lists,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "uuid": uuid,} }

    params[:"peer-group-neighbor"].each do |k, v|
        if not v 
            params[:"peer-group-neighbor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating peer-group-neighbor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/peer-group-neighbor/%<peer-group>s"
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    activate = new_resource.activate
    weight = new_resource.weight
    send_community_val = new_resource.send_community_val
    inbound = new_resource.inbound
    next_hop_self = new_resource.next_hop_self
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    route_map = new_resource.route_map
    peer_group = new_resource.peer_group
    remove_private_as = new_resource.remove_private_as
    default_originate = new_resource.default_originate
    allowas_in_count = new_resource.allowas_in_count
    distribute_lists = new_resource.distribute_lists
    prefix_list_direction = new_resource.prefix_list_direction
    allowas_in = new_resource.allowas_in
    unsuppress_map = new_resource.unsuppress_map
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    uuid = new_resource.uuid

    params = { "peer-group-neighbor": {"maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "activate": activate,
        "weight": weight,
        "send-community-val": send_community_val,
        "inbound": inbound,
        "next-hop-self": next_hop_self,
        "maximum-prefix-thres": maximum_prefix_thres,
        "route-map": route_map,
        "peer-group": peer_group,
        "remove-private-as": remove_private_as,
        "default-originate": default_originate,
        "allowas-in-count": allowas_in_count,
        "distribute-lists": distribute_lists,
        "prefix-list-direction": prefix_list_direction,
        "allowas-in": allowas_in,
        "unsuppress-map": unsuppress_map,
        "neighbor-filter-lists": neighbor_filter_lists,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "uuid": uuid,} }

    params[:"peer-group-neighbor"].each do |k, v|
        if not v
            params[:"peer-group-neighbor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["peer-group-neighbor"].each do |k, v|
        if v != params[:"peer-group-neighbor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating peer-group-neighbor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/bgp/%<as-number>s/address-family/ipv6/neighbor/peer-group-neighbor/%<peer-group>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting peer-group-neighbor') do
            client.delete(url)
        end
    end
end