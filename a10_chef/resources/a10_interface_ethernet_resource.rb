resource_name :a10_interface_ethernet

property :a10_name, String, name_property: true
property :fec_forced_on, [true, false]
property :trap_source, [true, false]
property :ip, Hash
property :ddos, Hash
property :l3_vlan_fwd_disable, [true, false]
property :access_list, Hash
property :speed, ['10','100','1000','auto']
property :speed_forced_40g, [true, false]
property :lldp, Hash
property :uuid, String
property :bfd, Hash
property :media_type_copper, [true, false]
property :ifnum, String,required: true
property :remove_vlan_tag, [true, false]
property :monitor_list, Array
property :cpu_process, [true, false]
property :auto_neg_enable, [true, false]
property :map, Hash
property :traffic_distribution_mode, ['sip','dip','primary','blade','l4-src-port','l4-dst-port']
property :trunk_group_list, Array
property :nptv6, Hash
property :cpu_process_dir, ['primary','blade','hash-dip','hash-sip','hash-dmac','hash-smac']
property :isis, Hash
property :duplexity, ['Full','Half','auto']
property :icmpv6_rate_limit, Hash
property :user_tag, String
property :mtu, Integer
property :ipv6, Hash
property :sampling_enable, Array
property :load_interval, Integer
property :lw_4o6, Hash
property :a10_action, ['enable','disable']
property :fec_forced_off, [true, false]
property :icmp_rate_limit, Hash
property :flow_control, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s"
    fec_forced_on = new_resource.fec_forced_on
    trap_source = new_resource.trap_source
    ip = new_resource.ip
    ddos = new_resource.ddos
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    access_list = new_resource.access_list
    speed = new_resource.speed
    speed_forced_40g = new_resource.speed_forced_40g
    lldp = new_resource.lldp
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    media_type_copper = new_resource.media_type_copper
    ifnum = new_resource.ifnum
    remove_vlan_tag = new_resource.remove_vlan_tag
    monitor_list = new_resource.monitor_list
    cpu_process = new_resource.cpu_process
    auto_neg_enable = new_resource.auto_neg_enable
    map = new_resource.map
    traffic_distribution_mode = new_resource.traffic_distribution_mode
    trunk_group_list = new_resource.trunk_group_list
    nptv6 = new_resource.nptv6
    cpu_process_dir = new_resource.cpu_process_dir
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    duplexity = new_resource.duplexity
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ipv6 = new_resource.ipv6
    sampling_enable = new_resource.sampling_enable
    load_interval = new_resource.load_interval
    lw_4o6 = new_resource.lw_4o6
    a10_name = new_resource.a10_name
    fec_forced_off = new_resource.fec_forced_off
    icmp_rate_limit = new_resource.icmp_rate_limit
    flow_control = new_resource.flow_control

    params = { "ethernet": {"fec-forced-on": fec_forced_on,
        "trap-source": trap_source,
        "ip": ip,
        "ddos": ddos,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "access-list": access_list,
        "speed": speed,
        "speed-forced-40g": speed_forced_40g,
        "lldp": lldp,
        "uuid": uuid,
        "bfd": bfd,
        "media-type-copper": media_type_copper,
        "ifnum": ifnum,
        "remove-vlan-tag": remove_vlan_tag,
        "monitor-list": monitor_list,
        "cpu-process": cpu_process,
        "auto-neg-enable": auto_neg_enable,
        "map": map,
        "traffic-distribution-mode": traffic_distribution_mode,
        "trunk-group-list": trunk_group_list,
        "nptv6": nptv6,
        "cpu-process-dir": cpu_process_dir,
        "isis": isis,
        "name": a10_name,
        "duplexity": duplexity,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "ipv6": ipv6,
        "sampling-enable": sampling_enable,
        "load-interval": load_interval,
        "lw-4o6": lw_4o6,
        "action": a10_action,
        "fec-forced-off": fec_forced_off,
        "icmp-rate-limit": icmp_rate_limit,
        "flow-control": flow_control,} }

    params[:"ethernet"].each do |k, v|
        if not v 
            params[:"ethernet"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ethernet') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s"
    fec_forced_on = new_resource.fec_forced_on
    trap_source = new_resource.trap_source
    ip = new_resource.ip
    ddos = new_resource.ddos
    l3_vlan_fwd_disable = new_resource.l3_vlan_fwd_disable
    access_list = new_resource.access_list
    speed = new_resource.speed
    speed_forced_40g = new_resource.speed_forced_40g
    lldp = new_resource.lldp
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    media_type_copper = new_resource.media_type_copper
    ifnum = new_resource.ifnum
    remove_vlan_tag = new_resource.remove_vlan_tag
    monitor_list = new_resource.monitor_list
    cpu_process = new_resource.cpu_process
    auto_neg_enable = new_resource.auto_neg_enable
    map = new_resource.map
    traffic_distribution_mode = new_resource.traffic_distribution_mode
    trunk_group_list = new_resource.trunk_group_list
    nptv6 = new_resource.nptv6
    cpu_process_dir = new_resource.cpu_process_dir
    isis = new_resource.isis
    a10_name = new_resource.a10_name
    duplexity = new_resource.duplexity
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    ipv6 = new_resource.ipv6
    sampling_enable = new_resource.sampling_enable
    load_interval = new_resource.load_interval
    lw_4o6 = new_resource.lw_4o6
    a10_name = new_resource.a10_name
    fec_forced_off = new_resource.fec_forced_off
    icmp_rate_limit = new_resource.icmp_rate_limit
    flow_control = new_resource.flow_control

    params = { "ethernet": {"fec-forced-on": fec_forced_on,
        "trap-source": trap_source,
        "ip": ip,
        "ddos": ddos,
        "l3-vlan-fwd-disable": l3_vlan_fwd_disable,
        "access-list": access_list,
        "speed": speed,
        "speed-forced-40g": speed_forced_40g,
        "lldp": lldp,
        "uuid": uuid,
        "bfd": bfd,
        "media-type-copper": media_type_copper,
        "ifnum": ifnum,
        "remove-vlan-tag": remove_vlan_tag,
        "monitor-list": monitor_list,
        "cpu-process": cpu_process,
        "auto-neg-enable": auto_neg_enable,
        "map": map,
        "traffic-distribution-mode": traffic_distribution_mode,
        "trunk-group-list": trunk_group_list,
        "nptv6": nptv6,
        "cpu-process-dir": cpu_process_dir,
        "isis": isis,
        "name": a10_name,
        "duplexity": duplexity,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "user-tag": user_tag,
        "mtu": mtu,
        "ipv6": ipv6,
        "sampling-enable": sampling_enable,
        "load-interval": load_interval,
        "lw-4o6": lw_4o6,
        "action": a10_action,
        "fec-forced-off": fec_forced_off,
        "icmp-rate-limit": icmp_rate_limit,
        "flow-control": flow_control,} }

    params[:"ethernet"].each do |k, v|
        if not v
            params[:"ethernet"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ethernet"].each do |k, v|
        if v != params[:"ethernet"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ethernet') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ethernet') do
            client.delete(url)
        end
    end
end