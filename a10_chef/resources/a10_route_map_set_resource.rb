resource_name :a10_route_map_set

property :a10_name, String, name_property: true
property :extcommunity, Hash
property :origin, Hash
property :originator_id, Hash
property :weight, Hash
property :level, Hash
property :ip, Hash
property :metric, Hash
property :as_path, Hash
property :comm_list, Hash
property :atomic_aggregate, [true, false]
property :community, String
property :local_preference, Hash
property :ddos, Hash
property :tag, Hash
property :aggregator, Hash
property :dampening_cfg, Hash
property :ipv6, Hash
property :metric_type, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/"
    get_url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/set"
    extcommunity = new_resource.extcommunity
    origin = new_resource.origin
    originator_id = new_resource.originator_id
    weight = new_resource.weight
    level = new_resource.level
    ip = new_resource.ip
    metric = new_resource.metric
    as_path = new_resource.as_path
    comm_list = new_resource.comm_list
    atomic_aggregate = new_resource.atomic_aggregate
    community = new_resource.community
    local_preference = new_resource.local_preference
    ddos = new_resource.ddos
    tag = new_resource.tag
    aggregator = new_resource.aggregator
    dampening_cfg = new_resource.dampening_cfg
    ipv6 = new_resource.ipv6
    metric_type = new_resource.metric_type
    uuid = new_resource.uuid

    params = { "set": {"extcommunity": extcommunity,
        "origin": origin,
        "originator-id": originator_id,
        "weight": weight,
        "level": level,
        "ip": ip,
        "metric": metric,
        "as-path": as_path,
        "comm-list": comm_list,
        "atomic-aggregate": atomic_aggregate,
        "community": community,
        "local-preference": local_preference,
        "ddos": ddos,
        "tag": tag,
        "aggregator": aggregator,
        "dampening-cfg": dampening_cfg,
        "ipv6": ipv6,
        "metric-type": metric_type,
        "uuid": uuid,} }

    params[:"set"].each do |k, v|
        if not v 
            params[:"set"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating set') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/set"
    extcommunity = new_resource.extcommunity
    origin = new_resource.origin
    originator_id = new_resource.originator_id
    weight = new_resource.weight
    level = new_resource.level
    ip = new_resource.ip
    metric = new_resource.metric
    as_path = new_resource.as_path
    comm_list = new_resource.comm_list
    atomic_aggregate = new_resource.atomic_aggregate
    community = new_resource.community
    local_preference = new_resource.local_preference
    ddos = new_resource.ddos
    tag = new_resource.tag
    aggregator = new_resource.aggregator
    dampening_cfg = new_resource.dampening_cfg
    ipv6 = new_resource.ipv6
    metric_type = new_resource.metric_type
    uuid = new_resource.uuid

    params = { "set": {"extcommunity": extcommunity,
        "origin": origin,
        "originator-id": originator_id,
        "weight": weight,
        "level": level,
        "ip": ip,
        "metric": metric,
        "as-path": as_path,
        "comm-list": comm_list,
        "atomic-aggregate": atomic_aggregate,
        "community": community,
        "local-preference": local_preference,
        "ddos": ddos,
        "tag": tag,
        "aggregator": aggregator,
        "dampening-cfg": dampening_cfg,
        "ipv6": ipv6,
        "metric-type": metric_type,
        "uuid": uuid,} }

    params[:"set"].each do |k, v|
        if not v
            params[:"set"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["set"].each do |k, v|
        if v != params[:"set"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating set') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/set"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting set') do
            client.delete(url)
        end
    end
end