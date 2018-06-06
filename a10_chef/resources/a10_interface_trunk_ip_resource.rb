resource_name :a10_interface_trunk_ip

property :a10_name, String, name_property: true
property :nat, Hash
property :uuid, String
property :address_list, Array
property :generate_membership_query, [true, false]
property :cache_spoofing_port, [true, false]
property :router, Hash
property :allow_promiscuous_vip, [true, false]
property :server, [true, false]
property :max_resp_time, Integer
property :query_interval, Integer
property :helper_address_list, Array
property :stateful_firewall, Hash
property :client, [true, false]
property :rip, Hash
property :ttl_ignore, [true, false]
property :dhcp, [true, false]
property :ospf, Hash
property :slb_partition_redirect, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/trunk/%<ifnum>s/"
    get_url = "/axapi/v3/interface/trunk/%<ifnum>s/ip"
    nat = new_resource.nat
    uuid = new_resource.uuid
    address_list = new_resource.address_list
    generate_membership_query = new_resource.generate_membership_query
    cache_spoofing_port = new_resource.cache_spoofing_port
    router = new_resource.router
    allow_promiscuous_vip = new_resource.allow_promiscuous_vip
    server = new_resource.server
    max_resp_time = new_resource.max_resp_time
    query_interval = new_resource.query_interval
    helper_address_list = new_resource.helper_address_list
    stateful_firewall = new_resource.stateful_firewall
    client = new_resource.client
    rip = new_resource.rip
    ttl_ignore = new_resource.ttl_ignore
    dhcp = new_resource.dhcp
    ospf = new_resource.ospf
    slb_partition_redirect = new_resource.slb_partition_redirect

    params = { "ip": {"nat": nat,
        "uuid": uuid,
        "address-list": address_list,
        "generate-membership-query": generate_membership_query,
        "cache-spoofing-port": cache_spoofing_port,
        "router": router,
        "allow-promiscuous-vip": allow_promiscuous_vip,
        "server": server,
        "max-resp-time": max_resp_time,
        "query-interval": query_interval,
        "helper-address-list": helper_address_list,
        "stateful-firewall": stateful_firewall,
        "client": client,
        "rip": rip,
        "ttl-ignore": ttl_ignore,
        "dhcp": dhcp,
        "ospf": ospf,
        "slb-partition-redirect": slb_partition_redirect,} }

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
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ip"
    nat = new_resource.nat
    uuid = new_resource.uuid
    address_list = new_resource.address_list
    generate_membership_query = new_resource.generate_membership_query
    cache_spoofing_port = new_resource.cache_spoofing_port
    router = new_resource.router
    allow_promiscuous_vip = new_resource.allow_promiscuous_vip
    server = new_resource.server
    max_resp_time = new_resource.max_resp_time
    query_interval = new_resource.query_interval
    helper_address_list = new_resource.helper_address_list
    stateful_firewall = new_resource.stateful_firewall
    client = new_resource.client
    rip = new_resource.rip
    ttl_ignore = new_resource.ttl_ignore
    dhcp = new_resource.dhcp
    ospf = new_resource.ospf
    slb_partition_redirect = new_resource.slb_partition_redirect

    params = { "ip": {"nat": nat,
        "uuid": uuid,
        "address-list": address_list,
        "generate-membership-query": generate_membership_query,
        "cache-spoofing-port": cache_spoofing_port,
        "router": router,
        "allow-promiscuous-vip": allow_promiscuous_vip,
        "server": server,
        "max-resp-time": max_resp_time,
        "query-interval": query_interval,
        "helper-address-list": helper_address_list,
        "stateful-firewall": stateful_firewall,
        "client": client,
        "rip": rip,
        "ttl-ignore": ttl_ignore,
        "dhcp": dhcp,
        "ospf": ospf,
        "slb-partition-redirect": slb_partition_redirect,} }

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
    url = "/axapi/v3/interface/trunk/%<ifnum>s/ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end