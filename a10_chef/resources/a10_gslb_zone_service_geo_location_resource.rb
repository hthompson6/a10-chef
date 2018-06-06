resource_name :a10_gslb_zone_service_geo_location

property :a10_name, String, name_property: true
property :action_type, ['allow','drop','forward','ignore','reject']
property :uuid, String
property :user_tag, String
property :a10_alias, Array
property :geo_name, String,required: true
property :policy, String
property :forward_type, ['both','query','response']
property :a10_action, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/geo-location/"
    get_url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/geo-location/%<geo-name>s"
    action_type = new_resource.action_type
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    geo_name = new_resource.geo_name
    policy = new_resource.policy
    forward_type = new_resource.forward_type
    a10_name = new_resource.a10_name

    params = { "geo-location": {"action-type": action_type,
        "uuid": uuid,
        "user-tag": user_tag,
        "alias": a10_alias,
        "geo-name": geo_name,
        "policy": policy,
        "forward-type": forward_type,
        "action": a10_action,} }

    params[:"geo-location"].each do |k, v|
        if not v 
            params[:"geo-location"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating geo-location') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/geo-location/%<geo-name>s"
    action_type = new_resource.action_type
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    geo_name = new_resource.geo_name
    policy = new_resource.policy
    forward_type = new_resource.forward_type
    a10_name = new_resource.a10_name

    params = { "geo-location": {"action-type": action_type,
        "uuid": uuid,
        "user-tag": user_tag,
        "alias": a10_alias,
        "geo-name": geo_name,
        "policy": policy,
        "forward-type": forward_type,
        "action": a10_action,} }

    params[:"geo-location"].each do |k, v|
        if not v
            params[:"geo-location"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["geo-location"].each do |k, v|
        if v != params[:"geo-location"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating geo-location') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/zone/%<name>s/service/%<service-port>s+%<service-name>s/geo-location/%<geo-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting geo-location') do
            client.delete(url)
        end
    end
end