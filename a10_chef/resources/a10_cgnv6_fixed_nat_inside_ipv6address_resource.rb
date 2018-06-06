resource_name :a10_cgnv6_fixed_nat_inside_ipv6address

property :a10_name, String, name_property: true
property :partition, String,required: true
property :inside_netmask, Integer,required: true
property :uuid, String
property :nat_end_address, String
property :vrid, Integer
property :ports_per_user, Integer
property :session_quota, Integer
property :a10_method, ['use-all-nat-ips','use-least-nat-ips']
property :inside_start_address, String,required: true
property :dest_rule_list, String
property :nat_start_address, String
property :nat_ip_list, String
property :offset, Hash
property :respond_to_user_mac, [true, false]
property :inside_end_address, String,required: true
property :usable_nat_ports, Hash
property :nat_netmask, String
property :dynamic_pool_size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/fixed-nat/inside/ipv6address/"
    get_url = "/axapi/v3/cgnv6/fixed-nat/inside/ipv6address/%<inside-start-address>s+%<inside-end-address>s+%<inside-netmask>s+%<partition>s"
    partition = new_resource.partition
    inside_netmask = new_resource.inside_netmask
    uuid = new_resource.uuid
    nat_end_address = new_resource.nat_end_address
    vrid = new_resource.vrid
    ports_per_user = new_resource.ports_per_user
    session_quota = new_resource.session_quota
    a10_name = new_resource.a10_name
    inside_start_address = new_resource.inside_start_address
    dest_rule_list = new_resource.dest_rule_list
    nat_start_address = new_resource.nat_start_address
    nat_ip_list = new_resource.nat_ip_list
    offset = new_resource.offset
    respond_to_user_mac = new_resource.respond_to_user_mac
    inside_end_address = new_resource.inside_end_address
    usable_nat_ports = new_resource.usable_nat_ports
    nat_netmask = new_resource.nat_netmask
    dynamic_pool_size = new_resource.dynamic_pool_size

    params = { "ipv6address": {"partition": partition,
        "inside-netmask": inside_netmask,
        "uuid": uuid,
        "nat-end-address": nat_end_address,
        "vrid": vrid,
        "ports-per-user": ports_per_user,
        "session-quota": session_quota,
        "method": a10_method,
        "inside-start-address": inside_start_address,
        "dest-rule-list": dest_rule_list,
        "nat-start-address": nat_start_address,
        "nat-ip-list": nat_ip_list,
        "offset": offset,
        "respond-to-user-mac": respond_to_user_mac,
        "inside-end-address": inside_end_address,
        "usable-nat-ports": usable_nat_ports,
        "nat-netmask": nat_netmask,
        "dynamic-pool-size": dynamic_pool_size,} }

    params[:"ipv6address"].each do |k, v|
        if not v 
            params[:"ipv6address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/inside/ipv6address/%<inside-start-address>s+%<inside-end-address>s+%<inside-netmask>s+%<partition>s"
    partition = new_resource.partition
    inside_netmask = new_resource.inside_netmask
    uuid = new_resource.uuid
    nat_end_address = new_resource.nat_end_address
    vrid = new_resource.vrid
    ports_per_user = new_resource.ports_per_user
    session_quota = new_resource.session_quota
    a10_name = new_resource.a10_name
    inside_start_address = new_resource.inside_start_address
    dest_rule_list = new_resource.dest_rule_list
    nat_start_address = new_resource.nat_start_address
    nat_ip_list = new_resource.nat_ip_list
    offset = new_resource.offset
    respond_to_user_mac = new_resource.respond_to_user_mac
    inside_end_address = new_resource.inside_end_address
    usable_nat_ports = new_resource.usable_nat_ports
    nat_netmask = new_resource.nat_netmask
    dynamic_pool_size = new_resource.dynamic_pool_size

    params = { "ipv6address": {"partition": partition,
        "inside-netmask": inside_netmask,
        "uuid": uuid,
        "nat-end-address": nat_end_address,
        "vrid": vrid,
        "ports-per-user": ports_per_user,
        "session-quota": session_quota,
        "method": a10_method,
        "inside-start-address": inside_start_address,
        "dest-rule-list": dest_rule_list,
        "nat-start-address": nat_start_address,
        "nat-ip-list": nat_ip_list,
        "offset": offset,
        "respond-to-user-mac": respond_to_user_mac,
        "inside-end-address": inside_end_address,
        "usable-nat-ports": usable_nat_ports,
        "nat-netmask": nat_netmask,
        "dynamic-pool-size": dynamic_pool_size,} }

    params[:"ipv6address"].each do |k, v|
        if not v
            params[:"ipv6address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6address"].each do |k, v|
        if v != params[:"ipv6address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/inside/ipv6address/%<inside-start-address>s+%<inside-end-address>s+%<inside-netmask>s+%<partition>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6address') do
            client.delete(url)
        end
    end
end