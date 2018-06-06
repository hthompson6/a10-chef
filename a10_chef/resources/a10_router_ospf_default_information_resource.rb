resource_name :a10_router_ospf_default_information

property :a10_name, String, name_property: true
property :originate, [true, false]
property :uuid, String
property :always, [true, false]
property :metric, Integer
property :route_map, String
property :metric_type, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ospf/%<process-id>s/"
    get_url = "/axapi/v3/router/ospf/%<process-id>s/default-information"
    originate = new_resource.originate
    uuid = new_resource.uuid
    always = new_resource.always
    metric = new_resource.metric
    route_map = new_resource.route_map
    metric_type = new_resource.metric_type

    params = { "default-information": {"originate": originate,
        "uuid": uuid,
        "always": always,
        "metric": metric,
        "route-map": route_map,
        "metric-type": metric_type,} }

    params[:"default-information"].each do |k, v|
        if not v 
            params[:"default-information"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating default-information') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/default-information"
    originate = new_resource.originate
    uuid = new_resource.uuid
    always = new_resource.always
    metric = new_resource.metric
    route_map = new_resource.route_map
    metric_type = new_resource.metric_type

    params = { "default-information": {"originate": originate,
        "uuid": uuid,
        "always": always,
        "metric": metric,
        "route-map": route_map,
        "metric-type": metric_type,} }

    params[:"default-information"].each do |k, v|
        if not v
            params[:"default-information"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["default-information"].each do |k, v|
        if v != params[:"default-information"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating default-information') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/default-information"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default-information') do
            client.delete(url)
        end
    end
end