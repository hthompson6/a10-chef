resource_name :a10_interface_trunk

property :a10_name, String, name_property: true
property :trap_source, [true, false]
property :ip, Hash
property :ddos, Hash
property :timer, Integer
property :access_list, Hash
property :uuid, String
property :bfd, Hash
property :do_auto_recovery, [true, false]
property :ipv6, Hash
property :map, Hash
property :ports_threshold, Integer
property :nptv6, Hash
property :icmp_rate_limit, Hash
property :isis, Hash
property :icmpv6_rate_limit, Hash
property :user_tag, String
property :mtu, Integer
property :ifnum, Integer,required: true
property :lw_4o6, Hash
property :a10_action, ['enable','disable']
property :l3_vlan_fwd_disable, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/trunk/"
    get_url = "/axapi/v3/interface/trunk/%<ifnum>s"
    trap_source = new_resource.trap_source
    ip = new_resource.ip
    ddos = new_resource.ddos
    timer = new_resource.timer
    access_list = new_resource.access_list
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    do_auto_recovery = new_resource.do_auto_recovery
    ipv6 = new_resource.ipv6
    map = new_resource.map
    ports_threshold = new_resource.ports_threshold
    nptv6 = new_resource.nptv6
    icmp_rate_limit = new_resource.icmp_rate_limit
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ifnum = new_resource.ifnum
    lw_4o6 = new_resource.lw_4o6
    a10_name = new_resource.a10_name
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable

    params = { "trunk": {"trap-source": trap_source,
        "ip": ip,
        "ddos": ddos,
        "timer": timer,
        "access-list": access_list,
        "uuid": uuid,
        "bfd": bfd,
        "do-auto-recovery": do_auto_recovery,
        "ipv6": ipv6,
        "map": map,
        "ports-threshold": ports_threshold,
        "nptv6": nptv6,
        "icmp-rate-limit": icmp_rate_limit,
        "isis": isis,
        "name": a10_name,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "ifnum": ifnum,
        "lw-4o6": lw_4o6,
        "action": a10_action,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,} }

    params[:"trunk"].each do |k, v|
        if not v 
            params[:"trunk"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trunk') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s"
    trap_source = new_resource.trap_source
    ip = new_resource.ip
    ddos = new_resource.ddos
    timer = new_resource.timer
    access_list = new_resource.access_list
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    do_auto_recovery = new_resource.do_auto_recovery
    ipv6 = new_resource.ipv6
    map = new_resource.map
    ports_threshold = new_resource.ports_threshold
    nptv6 = new_resource.nptv6
    icmp_rate_limit = new_resource.icmp_rate_limit
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ifnum = new_resource.ifnum
    lw_4o6 = new_resource.lw_4o6
    a10_name = new_resource.a10_name
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable

    params = { "trunk": {"trap-source": trap_source,
        "ip": ip,
        "ddos": ddos,
        "timer": timer,
        "access-list": access_list,
        "uuid": uuid,
        "bfd": bfd,
        "do-auto-recovery": do_auto_recovery,
        "ipv6": ipv6,
        "map": map,
        "ports-threshold": ports_threshold,
        "nptv6": nptv6,
        "icmp-rate-limit": icmp_rate_limit,
        "isis": isis,
        "name": a10_name,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "ifnum": ifnum,
        "lw-4o6": lw_4o6,
        "action": a10_action,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,} }

    params[:"trunk"].each do |k, v|
        if not v
            params[:"trunk"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trunk"].each do |k, v|
        if v != params[:"trunk"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trunk') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/trunk/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trunk') do
            client.delete(url)
        end
    end
end