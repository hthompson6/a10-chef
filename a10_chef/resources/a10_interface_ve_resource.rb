resource_name :a10_interface_ve

property :a10_name, String, name_property: true
property :map, Hash
property :nptv6, Hash
property :isis, Hash
property :trap_source, [true, false]
property :bfd, Hash
property :ip, Hash
property :icmpv6_rate_limit, Hash
property :user_tag, String
property :mtu, Integer
property :a10_action, ['enable','disable']
property :ifnum, Integer,required: true
property :sampling_enable, Array
property :lw_4o6, Hash
property :ipv6, Hash
property :access_list, Hash
property :l3_vlan_fwd_disable, [true, false]
property :icmp_rate_limit, Hash
property :ddos, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s"
    map = new_resource.map
    nptv6 = new_resource.nptv6
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    trap_source = new_resource.trap_source
    bfd = new_resource.bfd
    ip = new_resource.ip
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    a10_name = new_resource.a10_name
    ifnum = new_resource.ifnum
    sampling_enable = new_resource.sampling_enable
    lw_4o6 = new_resource.lw_4o6
    ipv6 = new_resource.ipv6
    access_list = new_resource.access_list
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    icmp_rate_limit = new_resource.icmp_rate_limit
    ddos = new_resource.ddos
    uuid = new_resource.uuid

    params = { "ve": {"map": map,
        "nptv6": nptv6,
        "isis": isis,
        "name": a10_name,
        "trap-source": trap_source,
        "bfd": bfd,
        "ip": ip,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "action": a10_action,
        "ifnum": ifnum,
        "sampling-enable": sampling_enable,
        "lw-4o6": lw_4o6,
        "ipv6": ipv6,
        "access-list": access_list,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "icmp-rate-limit": icmp_rate_limit,
        "ddos": ddos,
        "uuid": uuid,} }

    params[:"ve"].each do |k, v|
        if not v 
            params[:"ve"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ve') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s"
    map = new_resource.map
    nptv6 = new_resource.nptv6
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    trap_source = new_resource.trap_source
    bfd = new_resource.bfd
    ip = new_resource.ip
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    a10_name = new_resource.a10_name
    ifnum = new_resource.ifnum
    sampling_enable = new_resource.sampling_enable
    lw_4o6 = new_resource.lw_4o6
    ipv6 = new_resource.ipv6
    access_list = new_resource.access_list
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    icmp_rate_limit = new_resource.icmp_rate_limit
    ddos = new_resource.ddos
    uuid = new_resource.uuid

    params = { "ve": {"map": map,
        "nptv6": nptv6,
        "isis": isis,
        "name": a10_name,
        "trap-source": trap_source,
        "bfd": bfd,
        "ip": ip,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "action": a10_action,
        "ifnum": ifnum,
        "sampling-enable": sampling_enable,
        "lw-4o6": lw_4o6,
        "ipv6": ipv6,
        "access-list": access_list,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "icmp-rate-limit": icmp_rate_limit,
        "ddos": ddos,
        "uuid": uuid,} }

    params[:"ve"].each do |k, v|
        if not v
            params[:"ve"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ve"].each do |k, v|
        if v != params[:"ve"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ve') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ve') do
            client.delete(url)
        end
    end
end