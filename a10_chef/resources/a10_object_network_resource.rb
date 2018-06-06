resource_name :a10_object_network

property :a10_name, String, name_property: true
property :ipv6_subnet, String
property :subnet, String
property :description, String
property :ip_range_end, String
property :user_tag, String
property :ipv6_range_start, String
property :net_name, String,required: true
property :ipv6_range_end, String
property :ip_range_start, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/object/network/"
    get_url = "/axapi/v3/object/network/%<net-name>s"
    ipv6_subnet = new_resource.ipv6_subnet
    subnet = new_resource.subnet
    description = new_resource.description
    ip_range_end = new_resource.ip_range_end
    user_tag = new_resource.user_tag
    ipv6_range_start = new_resource.ipv6_range_start
    net_name = new_resource.net_name
    ipv6_range_end = new_resource.ipv6_range_end
    ip_range_start = new_resource.ip_range_start
    uuid = new_resource.uuid

    params = { "network": {"ipv6-subnet": ipv6_subnet,
        "subnet": subnet,
        "description": description,
        "ip-range-end": ip_range_end,
        "user-tag": user_tag,
        "ipv6-range-start": ipv6_range_start,
        "net-name": net_name,
        "ipv6-range-end": ipv6_range_end,
        "ip-range-start": ip_range_start,
        "uuid": uuid,} }

    params[:"network"].each do |k, v|
        if not v 
            params[:"network"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating network') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object/network/%<net-name>s"
    ipv6_subnet = new_resource.ipv6_subnet
    subnet = new_resource.subnet
    description = new_resource.description
    ip_range_end = new_resource.ip_range_end
    user_tag = new_resource.user_tag
    ipv6_range_start = new_resource.ipv6_range_start
    net_name = new_resource.net_name
    ipv6_range_end = new_resource.ipv6_range_end
    ip_range_start = new_resource.ip_range_start
    uuid = new_resource.uuid

    params = { "network": {"ipv6-subnet": ipv6_subnet,
        "subnet": subnet,
        "description": description,
        "ip-range-end": ip_range_end,
        "user-tag": user_tag,
        "ipv6-range-start": ipv6_range_start,
        "net-name": net_name,
        "ipv6-range-end": ipv6_range_end,
        "ip-range-start": ip_range_start,
        "uuid": uuid,} }

    params[:"network"].each do |k, v|
        if not v
            params[:"network"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["network"].each do |k, v|
        if v != params[:"network"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating network') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object/network/%<net-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting network') do
            client.delete(url)
        end
    end
end