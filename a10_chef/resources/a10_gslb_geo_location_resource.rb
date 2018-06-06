resource_name :a10_gslb_geo_location

property :a10_name, String, name_property: true
property :geo_locn_obj_name, String,required: true
property :geo_locn_multiple_addresses, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/geo-location/"
    get_url = "/axapi/v3/gslb/geo-location/%<geo-locn-obj-name>s"
    geo_locn_obj_name = new_resource.geo_locn_obj_name
    geo_locn_multiple_addresses = new_resource.geo_locn_multiple_addresses
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "geo-location": {"geo-locn-obj-name": geo_locn_obj_name,
        "geo-locn-multiple-addresses": geo_locn_multiple_addresses,
        "user-tag": user_tag,
        "uuid": uuid,} }

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
    url = "/axapi/v3/gslb/geo-location/%<geo-locn-obj-name>s"
    geo_locn_obj_name = new_resource.geo_locn_obj_name
    geo_locn_multiple_addresses = new_resource.geo_locn_multiple_addresses
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "geo-location": {"geo-locn-obj-name": geo_locn_obj_name,
        "geo-locn-multiple-addresses": geo_locn_multiple_addresses,
        "user-tag": user_tag,
        "uuid": uuid,} }

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
    url = "/axapi/v3/gslb/geo-location/%<geo-locn-obj-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting geo-location') do
            client.delete(url)
        end
    end
end