resource_name :a10_gslb_policy_geo_location_match

property :a10_name, String, name_property: true
property :match_first, ['global','policy']
property :uuid, String
property :geo_type_overlap, ['global','policy']
property :overlap, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/geo-location-match"
    match_first = new_resource.match_first
    uuid = new_resource.uuid
    geo_type_overlap = new_resource.geo_type_overlap
    overlap = new_resource.overlap

    params = { "geo-location-match": {"match-first": match_first,
        "uuid": uuid,
        "geo-type-overlap": geo_type_overlap,
        "overlap": overlap,} }

    params[:"geo-location-match"].each do |k, v|
        if not v 
            params[:"geo-location-match"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating geo-location-match') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/geo-location-match"
    match_first = new_resource.match_first
    uuid = new_resource.uuid
    geo_type_overlap = new_resource.geo_type_overlap
    overlap = new_resource.overlap

    params = { "geo-location-match": {"match-first": match_first,
        "uuid": uuid,
        "geo-type-overlap": geo_type_overlap,
        "overlap": overlap,} }

    params[:"geo-location-match"].each do |k, v|
        if not v
            params[:"geo-location-match"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["geo-location-match"].each do |k, v|
        if v != params[:"geo-location-match"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating geo-location-match') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/geo-location-match"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting geo-location-match') do
            client.delete(url)
        end
    end
end