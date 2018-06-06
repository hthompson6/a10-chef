resource_name :a10_route_map

property :a10_name, String, name_property: true
property :set, Hash
property :uuid, String
property :sequence, Integer,required: true
property :user_tag, String
property :tag, String,required: true
property :a10_action, ['permit','deny'],required: true
property :match, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/route-map/"
    get_url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s"
    set = new_resource.set
    uuid = new_resource.uuid
    sequence = new_resource.sequence
    user_tag = new_resource.user_tag
    tag = new_resource.tag
    a10_name = new_resource.a10_name
    match = new_resource.match

    params = { "route-map": {"set": set,
        "uuid": uuid,
        "sequence": sequence,
        "user-tag": user_tag,
        "tag": tag,
        "action": a10_action,
        "match": match,} }

    params[:"route-map"].each do |k, v|
        if not v 
            params[:"route-map"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating route-map') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s"
    set = new_resource.set
    uuid = new_resource.uuid
    sequence = new_resource.sequence
    user_tag = new_resource.user_tag
    tag = new_resource.tag
    a10_name = new_resource.a10_name
    match = new_resource.match

    params = { "route-map": {"set": set,
        "uuid": uuid,
        "sequence": sequence,
        "user-tag": user_tag,
        "tag": tag,
        "action": a10_action,
        "match": match,} }

    params[:"route-map"].each do |k, v|
        if not v
            params[:"route-map"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["route-map"].each do |k, v|
        if v != params[:"route-map"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating route-map') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/route-map/%<tag>s+%<action>s+%<sequence>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting route-map') do
            client.delete(url)
        end
    end
end