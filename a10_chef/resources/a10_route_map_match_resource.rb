resource_name :a10_route_map_match

property :a10_name, String, name_property: true
property :extcommunity, Hash
property :origin, Hash
property :group, Hash
property :uuid, String
property :ip, Hash
property :metric, Hash
property :as_path, Hash
property :community, Hash
property :local_preference, Hash
property :route_type, Hash
property :tag, Hash
property :ipv6, Hash
property :interface, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/"
    get_url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/match"
    extcommunity = new_resource.extcommunity
    origin = new_resource.origin
    group = new_resource.group
    uuid = new_resource.uuid
    ip = new_resource.ip
    metric = new_resource.metric
    as_path = new_resource.as_path
    community = new_resource.community
    local_preference = new_resource.local_preference
    route_type = new_resource.route_type
    tag = new_resource.tag
    ipv6 = new_resource.ipv6
    interface = new_resource.interface

    params = { "match": {"extcommunity": extcommunity,
        "origin": origin,
        "group": group,
        "uuid": uuid,
        "ip": ip,
        "metric": metric,
        "as-path": as_path,
        "community": community,
        "local-preference": local_preference,
        "route-type": route_type,
        "tag": tag,
        "ipv6": ipv6,
        "interface": interface,} }

    params[:"match"].each do |k, v|
        if not v 
            params[:"match"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating match') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/match"
    extcommunity = new_resource.extcommunity
    origin = new_resource.origin
    group = new_resource.group
    uuid = new_resource.uuid
    ip = new_resource.ip
    metric = new_resource.metric
    as_path = new_resource.as_path
    community = new_resource.community
    local_preference = new_resource.local_preference
    route_type = new_resource.route_type
    tag = new_resource.tag
    ipv6 = new_resource.ipv6
    interface = new_resource.interface

    params = { "match": {"extcommunity": extcommunity,
        "origin": origin,
        "group": group,
        "uuid": uuid,
        "ip": ip,
        "metric": metric,
        "as-path": as_path,
        "community": community,
        "local-preference": local_preference,
        "route-type": route_type,
        "tag": tag,
        "ipv6": ipv6,
        "interface": interface,} }

    params[:"match"].each do |k, v|
        if not v
            params[:"match"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["match"].each do |k, v|
        if v != params[:"match"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating match') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s/match"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting match') do
            client.delete(url)
        end
    end
end