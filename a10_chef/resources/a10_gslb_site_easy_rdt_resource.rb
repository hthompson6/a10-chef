resource_name :a10_gslb_site_easy_rdt

property :a10_name, String, name_property: true
property :range_factor, Integer
property :smooth_factor, Integer
property :mask, String
property :overlap, [true, false]
property :limit, Integer
property :ignore_count, Integer
property :aging_time, Integer
property :bind_geoloc, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/site/%<site-name>s/"
    get_url = "/axapi/v3/gslb/site/%<site-name>s/easy-rdt"
    range_factor = new_resource.range_factor
    smooth_factor = new_resource.smooth_factor
    mask = new_resource.mask
    overlap = new_resource.overlap
    limit = new_resource.limit
    ignore_count = new_resource.ignore_count
    aging_time = new_resource.aging_time
    bind_geoloc = new_resource.bind_geoloc
    uuid = new_resource.uuid

    params = { "easy-rdt": {"range-factor": range_factor,
        "smooth-factor": smooth_factor,
        "mask": mask,
        "overlap": overlap,
        "limit": limit,
        "ignore-count": ignore_count,
        "aging-time": aging_time,
        "bind-geoloc": bind_geoloc,
        "uuid": uuid,} }

    params[:"easy-rdt"].each do |k, v|
        if not v 
            params[:"easy-rdt"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating easy-rdt') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/easy-rdt"
    range_factor = new_resource.range_factor
    smooth_factor = new_resource.smooth_factor
    mask = new_resource.mask
    overlap = new_resource.overlap
    limit = new_resource.limit
    ignore_count = new_resource.ignore_count
    aging_time = new_resource.aging_time
    bind_geoloc = new_resource.bind_geoloc
    uuid = new_resource.uuid

    params = { "easy-rdt": {"range-factor": range_factor,
        "smooth-factor": smooth_factor,
        "mask": mask,
        "overlap": overlap,
        "limit": limit,
        "ignore-count": ignore_count,
        "aging-time": aging_time,
        "bind-geoloc": bind_geoloc,
        "uuid": uuid,} }

    params[:"easy-rdt"].each do |k, v|
        if not v
            params[:"easy-rdt"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["easy-rdt"].each do |k, v|
        if v != params[:"easy-rdt"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating easy-rdt') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/easy-rdt"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting easy-rdt') do
            client.delete(url)
        end
    end
end