resource_name :a10_ip_route_static_bfd

property :a10_name, String, name_property: true
property :local_ip, String,required: true
property :nexthop_ip, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/route/static/bfd/"
    get_url = "/axapi/v3/ip/route/static/bfd/%<local-ip>s+%<nexthop-ip>s"
    local_ip = new_resource.local_ip
    nexthop_ip = new_resource.nexthop_ip
    uuid = new_resource.uuid

    params = { "bfd": {"local-ip": local_ip,
        "nexthop-ip": nexthop_ip,
        "uuid": uuid,} }

    params[:"bfd"].each do |k, v|
        if not v 
            params[:"bfd"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bfd') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/route/static/bfd/%<local-ip>s+%<nexthop-ip>s"
    local_ip = new_resource.local_ip
    nexthop_ip = new_resource.nexthop_ip
    uuid = new_resource.uuid

    params = { "bfd": {"local-ip": local_ip,
        "nexthop-ip": nexthop_ip,
        "uuid": uuid,} }

    params[:"bfd"].each do |k, v|
        if not v
            params[:"bfd"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bfd"].each do |k, v|
        if v != params[:"bfd"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bfd') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/route/static/bfd/%<local-ip>s+%<nexthop-ip>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bfd') do
            client.delete(url)
        end
    end
end