resource_name :a10_cgnv6_fixed_nat_inside_iplist

property :a10_name, String, name_property: true
property :partition, String,required: true
property :uuid, String
property :nat_end_address, String
property :vrid, Integer
property :ports_per_user, Integer
property :inside_ip_list, String,required: true
property :session_quota, Integer
property :a10_method, ['use-all-nat-ips','use-least-nat-ips']
property :dest_rule_list, String
property :nat_start_address, String
property :nat_ip_list, String
property :offset, Hash
property :respond_to_user_mac, [true, false]
property :usable_nat_ports, Hash
property :nat_netmask, String
property :dynamic_pool_size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/fixed-nat/inside/iplist/"
    get_url = "/axapi/v3/cgnv6/fixed-nat/inside/iplist/%<inside-ip-list>s+%<partition>s"
    partition = new_resource.partition
    uuid = new_resource.uuid
    nat_end_address = new_resource.nat_end_address
    vrid = new_resource.vrid
    ports_per_user = new_resource.ports_per_user
    inside_ip_list = new_resource.inside_ip_list
    session_quota = new_resource.session_quota
    a10_name = new_resource.a10_name
    dest_rule_list = new_resource.dest_rule_list
    nat_start_address = new_resource.nat_start_address
    nat_ip_list = new_resource.nat_ip_list
    offset = new_resource.offset
    respond_to_user_mac = new_resource.respond_to_user_mac
    usable_nat_ports = new_resource.usable_nat_ports
    nat_netmask = new_resource.nat_netmask
    dynamic_pool_size = new_resource.dynamic_pool_size

    params = { "iplist": {"partition": partition,
        "uuid": uuid,
        "nat-end-address": nat_end_address,
        "vrid": vrid,
        "ports-per-user": ports_per_user,
        "inside-ip-list": inside_ip_list,
        "session-quota": session_quota,
        "method": a10_method,
        "dest-rule-list": dest_rule_list,
        "nat-start-address": nat_start_address,
        "nat-ip-list": nat_ip_list,
        "offset": offset,
        "respond-to-user-mac": respond_to_user_mac,
        "usable-nat-ports": usable_nat_ports,
        "nat-netmask": nat_netmask,
        "dynamic-pool-size": dynamic_pool_size,} }

    params[:"iplist"].each do |k, v|
        if not v 
            params[:"iplist"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating iplist') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/inside/iplist/%<inside-ip-list>s+%<partition>s"
    partition = new_resource.partition
    uuid = new_resource.uuid
    nat_end_address = new_resource.nat_end_address
    vrid = new_resource.vrid
    ports_per_user = new_resource.ports_per_user
    inside_ip_list = new_resource.inside_ip_list
    session_quota = new_resource.session_quota
    a10_name = new_resource.a10_name
    dest_rule_list = new_resource.dest_rule_list
    nat_start_address = new_resource.nat_start_address
    nat_ip_list = new_resource.nat_ip_list
    offset = new_resource.offset
    respond_to_user_mac = new_resource.respond_to_user_mac
    usable_nat_ports = new_resource.usable_nat_ports
    nat_netmask = new_resource.nat_netmask
    dynamic_pool_size = new_resource.dynamic_pool_size

    params = { "iplist": {"partition": partition,
        "uuid": uuid,
        "nat-end-address": nat_end_address,
        "vrid": vrid,
        "ports-per-user": ports_per_user,
        "inside-ip-list": inside_ip_list,
        "session-quota": session_quota,
        "method": a10_method,
        "dest-rule-list": dest_rule_list,
        "nat-start-address": nat_start_address,
        "nat-ip-list": nat_ip_list,
        "offset": offset,
        "respond-to-user-mac": respond_to_user_mac,
        "usable-nat-ports": usable_nat_ports,
        "nat-netmask": nat_netmask,
        "dynamic-pool-size": dynamic_pool_size,} }

    params[:"iplist"].each do |k, v|
        if not v
            params[:"iplist"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["iplist"].each do |k, v|
        if v != params[:"iplist"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating iplist') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/fixed-nat/inside/iplist/%<inside-ip-list>s+%<partition>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting iplist') do
            client.delete(url)
        end
    end
end