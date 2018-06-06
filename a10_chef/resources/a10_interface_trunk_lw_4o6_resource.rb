resource_name :a10_interface_trunk_lw_4o6

property :a10_name, String, name_property: true
property :outside, [true, false]
property :inside, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/trunk/%<ifnum>s/"
    get_url = "/axapi/v3/interface/trunk/%<ifnum>s/lw-4o6"
    outside = new_resource.outside
    inside = new_resource.inside
    uuid = new_resource.uuid

    params = { "lw-4o6": {"outside": outside,
        "inside": inside,
        "uuid": uuid,} }

    params[:"lw-4o6"].each do |k, v|
        if not v 
            params[:"lw-4o6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lw-4o6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s/lw-4o6"
    outside = new_resource.outside
    inside = new_resource.inside
    uuid = new_resource.uuid

    params = { "lw-4o6": {"outside": outside,
        "inside": inside,
        "uuid": uuid,} }

    params[:"lw-4o6"].each do |k, v|
        if not v
            params[:"lw-4o6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lw-4o6"].each do |k, v|
        if v != params[:"lw-4o6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lw-4o6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s/lw-4o6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lw-4o6') do
            client.delete(url)
        end
    end
end