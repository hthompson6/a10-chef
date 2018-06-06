resource_name :a10_gslb_site

property :a10_name, String, name_property: true
property :ip_server_list, Array
property :uuid, String
property :weight, Integer
property :site_name, String,required: true
property :slb_dev_list, Array
property :controller, String
property :bw_cost, [true, false]
property :auto_map, [true, false]
property :sampling_enable, Array
property :disable, [true, false]
property :limit, Integer
property :user_tag, String
property :template, String
property :threshold, Integer
property :multiple_geo_locations, Array
property :easy_rdt, Hash
property :active_rdt, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/site/"
    get_url = "/axapi/v3/gslb/site/%<site-name>s"
    ip_server_list = new_resource.ip_server_list
    uuid = new_resource.uuid
    weight = new_resource.weight
    site_name = new_resource.site_name
    slb_dev_list = new_resource.slb_dev_list
    controller = new_resource.controller
    bw_cost = new_resource.bw_cost
    auto_map = new_resource.auto_map
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    limit = new_resource.limit
    user_tag = new_resource.user_tag
    template = new_resource.template
    threshold = new_resource.threshold
    multiple_geo_locations = new_resource.multiple_geo_locations
    easy_rdt = new_resource.easy_rdt
    active_rdt = new_resource.active_rdt

    params = { "site": {"ip-server-list": ip_server_list,
        "uuid": uuid,
        "weight": weight,
        "site-name": site_name,
        "slb-dev-list": slb_dev_list,
        "controller": controller,
        "bw-cost": bw_cost,
        "auto-map": auto_map,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "limit": limit,
        "user-tag": user_tag,
        "template": template,
        "threshold": threshold,
        "multiple-geo-locations": multiple_geo_locations,
        "easy-rdt": easy_rdt,
        "active-rdt": active_rdt,} }

    params[:"site"].each do |k, v|
        if not v 
            params[:"site"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating site') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s"
    ip_server_list = new_resource.ip_server_list
    uuid = new_resource.uuid
    weight = new_resource.weight
    site_name = new_resource.site_name
    slb_dev_list = new_resource.slb_dev_list
    controller = new_resource.controller
    bw_cost = new_resource.bw_cost
    auto_map = new_resource.auto_map
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    limit = new_resource.limit
    user_tag = new_resource.user_tag
    template = new_resource.template
    threshold = new_resource.threshold
    multiple_geo_locations = new_resource.multiple_geo_locations
    easy_rdt = new_resource.easy_rdt
    active_rdt = new_resource.active_rdt

    params = { "site": {"ip-server-list": ip_server_list,
        "uuid": uuid,
        "weight": weight,
        "site-name": site_name,
        "slb-dev-list": slb_dev_list,
        "controller": controller,
        "bw-cost": bw_cost,
        "auto-map": auto_map,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "limit": limit,
        "user-tag": user_tag,
        "template": template,
        "threshold": threshold,
        "multiple-geo-locations": multiple_geo_locations,
        "easy-rdt": easy_rdt,
        "active-rdt": active_rdt,} }

    params[:"site"].each do |k, v|
        if not v
            params[:"site"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["site"].each do |k, v|
        if v != params[:"site"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating site') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting site') do
            client.delete(url)
        end
    end
end