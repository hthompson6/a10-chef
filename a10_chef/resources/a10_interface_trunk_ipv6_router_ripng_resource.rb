resource_name :a10_interface_trunk_ipv6_router_ripng

property :a10_name, String, name_property: true
property :uuid, String
property :rip, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6/router/"
    get_url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6/router/ripng"
    uuid = new_resource.uuid
    rip = new_resource.rip

    params = { "ripng": {"uuid": uuid,
        "rip": rip,} }

    params[:"ripng"].each do |k, v|
        if not v 
            params[:"ripng"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ripng') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6/router/ripng"
    uuid = new_resource.uuid
    rip = new_resource.rip

    params = { "ripng": {"uuid": uuid,
        "rip": rip,} }

    params[:"ripng"].each do |k, v|
        if not v
            params[:"ripng"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ripng"].each do |k, v|
        if v != params[:"ripng"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ripng') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ipv6/router/ripng"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ripng') do
            client.delete(url)
        end
    end
end