resource_name :a10_interface_lif_ip

property :a10_name, String, name_property: true
property :uuid, String
property :generate_membership_query, [true, false]
property :cache_spoofing_port, [true, false]
property :inside, [true, false]
property :allow_promiscuous_vip, [true, false]
property :max_resp_time, Integer
property :query_interval, Integer
property :outside, [true, false]
property :dhcp, [true, false]
property :rip, Hash
property :address_list, Array
property :router, Hash
property :ospf, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/lif/%<ifnum>s/"
    get_url = "/axapi/v3/interface/lif/%<ifnum>s/ip"
    uuid = new_resource.uuid
    generate_membership_query = new_resource.generate_membership_query
    cache_spoofing_port = new_resource.cache_spoofing_port
    inside = new_resource.inside
    allow_promiscuous_vip = new_resource.allow_promiscuous_vip
    max_resp_time = new_resource.max_resp_time
    query_interval = new_resource.query_interval
    outside = new_resource.outside
    dhcp = new_resource.dhcp
    rip = new_resource.rip
    address_list = new_resource.address_list
    router = new_resource.router
    ospf = new_resource.ospf

    params = { "ip": {"uuid": uuid,
        "generate-membership-query": generate_membership_query,
        "cache-spoofing-port": cache_spoofing_port,
        "inside": inside,
        "allow-promiscuous-vip": allow_promiscuous_vip,
        "max-resp-time": max_resp_time,
        "query-interval": query_interval,
        "outside": outside,
        "dhcp": dhcp,
        "rip": rip,
        "address-list": address_list,
        "router": router,
        "ospf": ospf,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s/ip"
    uuid = new_resource.uuid
    generate_membership_query = new_resource.generate_membership_query
    cache_spoofing_port = new_resource.cache_spoofing_port
    inside = new_resource.inside
    allow_promiscuous_vip = new_resource.allow_promiscuous_vip
    max_resp_time = new_resource.max_resp_time
    query_interval = new_resource.query_interval
    outside = new_resource.outside
    dhcp = new_resource.dhcp
    rip = new_resource.rip
    address_list = new_resource.address_list
    router = new_resource.router
    ospf = new_resource.ospf

    params = { "ip": {"uuid": uuid,
        "generate-membership-query": generate_membership_query,
        "cache-spoofing-port": cache_spoofing_port,
        "inside": inside,
        "allow-promiscuous-vip": allow_promiscuous_vip,
        "max-resp-time": max_resp_time,
        "query-interval": query_interval,
        "outside": outside,
        "dhcp": dhcp,
        "rip": rip,
        "address-list": address_list,
        "router": router,
        "ospf": ospf,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s/ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end