resource_name :a10_router_bgp_neighbor_ipv4_neighbor

property :a10_name, String, name_property: true
property :activate, [true, false]
property :route_refresh, [true, false]
property :ve, String
property :weight, Integer
property :timers_keepalive, Integer
property :bfd_value, String
property :key_type, ['md5','meticulous-md5','meticulous-sha1','sha1','simple']
property :dynamic, [true, false]
property :multihop, [true, false]
property :default_originate, [true, false]
property :distribute_lists, Array
property :shutdown, [true, false]
property :enforce_multihop, [true, false]
property :prefix_list_direction, ['both','receive','send']
property :nbr_remote_as, Integer
property :advertisement_interval, Integer
property :lif, Integer
property :neighbor_route_map_lists, Array
property :uuid, String
property :send_community_val, ['both','none','standard','extended']
property :loopback, String
property :collide_established, [true, false]
property :next_hop_self, [true, false]
property :pass_encrypted, String
property :dont_capability_negotiate, [true, false]
property :unsuppress_map, String
property :passive, [true, false]
property :ebgp_multihop_hop_count, Integer
property :allowas_in, [true, false]
property :acos_application_only, [true, false]
property :pass_value, String
property :key_id, Integer
property :timers_holdtime, Integer
property :update_source_ip, String
property :description, String
property :neighbor_ipv4, String,required: true
property :inbound, [true, false]
property :maximum_prefix_thres, Integer
property :bfd_encrypted, String
property :disallow_infinite_holdtime, [true, false]
property :route_map, String
property :trunk, String
property :remove_private_as, [true, false]
property :neighbor_filter_lists, Array
property :update_source_ipv6, String
property :maximum_prefix, Integer
property :neighbor_prefix_lists, Array
property :allowas_in_count, Integer
property :peer_group_name, String
property :as_origination_interval, Integer
property :override_capability, [true, false]
property :bfd, [true, false]
property :tunnel, String
property :strict_capability_match, [true, false]
property :ebgp_multihop, [true, false]
property :ethernet, String
property :connect, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/bgp/%<as-number>s/neighbor/ipv4-neighbor/"
    get_url = "/axapi/v3/router/bgp/%<as-number>s/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"
    activate = new_resource.activate
    route_refresh = new_resource.route_refresh
    ve = new_resource.ve
    weight = new_resource.weight
    timers_keepalive = new_resource.timers_keepalive
    bfd_value = new_resource.bfd_value
    key_type = new_resource.key_type
    dynamic = new_resource.dynamic
    multihop = new_resource.multihop
    default_originate = new_resource.default_originate
    distribute_lists = new_resource.distribute_lists
    shutdown = new_resource.shutdown
    enforce_multihop = new_resource.enforce_multihop
    prefix_list_direction = new_resource.prefix_list_direction
    nbr_remote_as = new_resource.nbr_remote_as
    advertisement_interval = new_resource.advertisement_interval
    lif = new_resource.lif
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    uuid = new_resource.uuid
    send_community_val = new_resource.send_community_val
    loopback = new_resource.loopback
    collide_established = new_resource.collide_established
    next_hop_self = new_resource.next_hop_self
    pass_encrypted = new_resource.pass_encrypted
    dont_capability_negotiate = new_resource.dont_capability_negotiate
    unsuppress_map = new_resource.unsuppress_map
    passive = new_resource.passive
    ebgp_multihop_hop_count = new_resource.ebgp_multihop_hop_count
    allowas_in = new_resource.allowas_in
    acos_application_only = new_resource.acos_application_only
    pass_value = new_resource.pass_value
    key_id = new_resource.key_id
    timers_holdtime = new_resource.timers_holdtime
    update_source_ip = new_resource.update_source_ip
    description = new_resource.description
    neighbor_ipv4 = new_resource.neighbor_ipv4
    inbound = new_resource.inbound
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    bfd_encrypted = new_resource.bfd_encrypted
    disallow_infinite_holdtime = new_resource.disallow_infinite_holdtime
    route_map = new_resource.route_map
    trunk = new_resource.trunk
    remove_private_as = new_resource.remove_private_as
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    update_source_ipv6 = new_resource.update_source_ipv6
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    peer_group_name = new_resource.peer_group_name
    as_origination_interval = new_resource.as_origination_interval
    override_capability = new_resource.override_capability
    bfd = new_resource.bfd
    tunnel = new_resource.tunnel
    strict_capability_match = new_resource.strict_capability_match
    ebgp_multihop = new_resource.ebgp_multihop
    ethernet = new_resource.ethernet
    connect = new_resource.connect

    params = { "ipv4-neighbor": {"activate": activate,
        "route-refresh": route_refresh,
        "ve": ve,
        "weight": weight,
        "timers-keepalive": timers_keepalive,
        "bfd-value": bfd_value,
        "key-type": key_type,
        "dynamic": dynamic,
        "multihop": multihop,
        "default-originate": default_originate,
        "distribute-lists": distribute_lists,
        "shutdown": shutdown,
        "enforce-multihop": enforce_multihop,
        "prefix-list-direction": prefix_list_direction,
        "nbr-remote-as": nbr_remote_as,
        "advertisement-interval": advertisement_interval,
        "lif": lif,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "uuid": uuid,
        "send-community-val": send_community_val,
        "loopback": loopback,
        "collide-established": collide_established,
        "next-hop-self": next_hop_self,
        "pass-encrypted": pass_encrypted,
        "dont-capability-negotiate": dont_capability_negotiate,
        "unsuppress-map": unsuppress_map,
        "passive": passive,
        "ebgp-multihop-hop-count": ebgp_multihop_hop_count,
        "allowas-in": allowas_in,
        "acos-application-only": acos_application_only,
        "pass-value": pass_value,
        "key-id": key_id,
        "timers-holdtime": timers_holdtime,
        "update-source-ip": update_source_ip,
        "description": description,
        "neighbor-ipv4": neighbor_ipv4,
        "inbound": inbound,
        "maximum-prefix-thres": maximum_prefix_thres,
        "bfd-encrypted": bfd_encrypted,
        "disallow-infinite-holdtime": disallow_infinite_holdtime,
        "route-map": route_map,
        "trunk": trunk,
        "remove-private-as": remove_private_as,
        "neighbor-filter-lists": neighbor_filter_lists,
        "update-source-ipv6": update_source_ipv6,
        "maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "peer-group-name": peer_group_name,
        "as-origination-interval": as_origination_interval,
        "override-capability": override_capability,
        "bfd": bfd,
        "tunnel": tunnel,
        "strict-capability-match": strict_capability_match,
        "ebgp-multihop": ebgp_multihop,
        "ethernet": ethernet,
        "connect": connect,} }

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
    url = "/axapi/v3/router/bgp/%<as-number>s/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"
    activate = new_resource.activate
    route_refresh = new_resource.route_refresh
    ve = new_resource.ve
    weight = new_resource.weight
    timers_keepalive = new_resource.timers_keepalive
    bfd_value = new_resource.bfd_value
    key_type = new_resource.key_type
    dynamic = new_resource.dynamic
    multihop = new_resource.multihop
    default_originate = new_resource.default_originate
    distribute_lists = new_resource.distribute_lists
    shutdown = new_resource.shutdown
    enforce_multihop = new_resource.enforce_multihop
    prefix_list_direction = new_resource.prefix_list_direction
    nbr_remote_as = new_resource.nbr_remote_as
    advertisement_interval = new_resource.advertisement_interval
    lif = new_resource.lif
    neighbor_route_map_lists = new_resource.neighbor_route_map_lists
    uuid = new_resource.uuid
    send_community_val = new_resource.send_community_val
    loopback = new_resource.loopback
    collide_established = new_resource.collide_established
    next_hop_self = new_resource.next_hop_self
    pass_encrypted = new_resource.pass_encrypted
    dont_capability_negotiate = new_resource.dont_capability_negotiate
    unsuppress_map = new_resource.unsuppress_map
    passive = new_resource.passive
    ebgp_multihop_hop_count = new_resource.ebgp_multihop_hop_count
    allowas_in = new_resource.allowas_in
    acos_application_only = new_resource.acos_application_only
    pass_value = new_resource.pass_value
    key_id = new_resource.key_id
    timers_holdtime = new_resource.timers_holdtime
    update_source_ip = new_resource.update_source_ip
    description = new_resource.description
    neighbor_ipv4 = new_resource.neighbor_ipv4
    inbound = new_resource.inbound
    maximum_prefix_thres = new_resource.maximum_prefix_thres
    bfd_encrypted = new_resource.bfd_encrypted
    disallow_infinite_holdtime = new_resource.disallow_infinite_holdtime
    route_map = new_resource.route_map
    trunk = new_resource.trunk
    remove_private_as = new_resource.remove_private_as
    neighbor_filter_lists = new_resource.neighbor_filter_lists
    update_source_ipv6 = new_resource.update_source_ipv6
    maximum_prefix = new_resource.maximum_prefix
    neighbor_prefix_lists = new_resource.neighbor_prefix_lists
    allowas_in_count = new_resource.allowas_in_count
    peer_group_name = new_resource.peer_group_name
    as_origination_interval = new_resource.as_origination_interval
    override_capability = new_resource.override_capability
    bfd = new_resource.bfd
    tunnel = new_resource.tunnel
    strict_capability_match = new_resource.strict_capability_match
    ebgp_multihop = new_resource.ebgp_multihop
    ethernet = new_resource.ethernet
    connect = new_resource.connect

    params = { "ipv4-neighbor": {"activate": activate,
        "route-refresh": route_refresh,
        "ve": ve,
        "weight": weight,
        "timers-keepalive": timers_keepalive,
        "bfd-value": bfd_value,
        "key-type": key_type,
        "dynamic": dynamic,
        "multihop": multihop,
        "default-originate": default_originate,
        "distribute-lists": distribute_lists,
        "shutdown": shutdown,
        "enforce-multihop": enforce_multihop,
        "prefix-list-direction": prefix_list_direction,
        "nbr-remote-as": nbr_remote_as,
        "advertisement-interval": advertisement_interval,
        "lif": lif,
        "neighbor-route-map-lists": neighbor_route_map_lists,
        "uuid": uuid,
        "send-community-val": send_community_val,
        "loopback": loopback,
        "collide-established": collide_established,
        "next-hop-self": next_hop_self,
        "pass-encrypted": pass_encrypted,
        "dont-capability-negotiate": dont_capability_negotiate,
        "unsuppress-map": unsuppress_map,
        "passive": passive,
        "ebgp-multihop-hop-count": ebgp_multihop_hop_count,
        "allowas-in": allowas_in,
        "acos-application-only": acos_application_only,
        "pass-value": pass_value,
        "key-id": key_id,
        "timers-holdtime": timers_holdtime,
        "update-source-ip": update_source_ip,
        "description": description,
        "neighbor-ipv4": neighbor_ipv4,
        "inbound": inbound,
        "maximum-prefix-thres": maximum_prefix_thres,
        "bfd-encrypted": bfd_encrypted,
        "disallow-infinite-holdtime": disallow_infinite_holdtime,
        "route-map": route_map,
        "trunk": trunk,
        "remove-private-as": remove_private_as,
        "neighbor-filter-lists": neighbor_filter_lists,
        "update-source-ipv6": update_source_ipv6,
        "maximum-prefix": maximum_prefix,
        "neighbor-prefix-lists": neighbor_prefix_lists,
        "allowas-in-count": allowas_in_count,
        "peer-group-name": peer_group_name,
        "as-origination-interval": as_origination_interval,
        "override-capability": override_capability,
        "bfd": bfd,
        "tunnel": tunnel,
        "strict-capability-match": strict_capability_match,
        "ebgp-multihop": ebgp_multihop,
        "ethernet": ethernet,
        "connect": connect,} }

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
    url = "/axapi/v3/router/bgp/%<as-number>s/neighbor/ipv4-neighbor/%<neighbor-ipv4>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4-neighbor') do
            client.delete(url)
        end
    end
end