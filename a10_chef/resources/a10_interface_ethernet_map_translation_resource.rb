resource_name :a10_interface_ethernet_map_translation

property :a10_name, String, name_property: true
property :inside, [true, false]
property :outside, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/%<ifnum>s/map/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s/map/translation"
    inside = new_resource.inside
    outside = new_resource.outside
    uuid = new_resource.uuid

    params = { "translation": {"inside": inside,
        "outside": outside,
        "uuid": uuid,} }

    params[:"translation"].each do |k, v|
        if not v 
            params[:"translation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating translation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/map/translation"
    inside = new_resource.inside
    outside = new_resource.outside
    uuid = new_resource.uuid

    params = { "translation": {"inside": inside,
        "outside": outside,
        "uuid": uuid,} }

    params[:"translation"].each do |k, v|
        if not v
            params[:"translation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["translation"].each do |k, v|
        if v != params[:"translation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating translation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/map/translation"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting translation') do
            client.delete(url)
        end
    end
end