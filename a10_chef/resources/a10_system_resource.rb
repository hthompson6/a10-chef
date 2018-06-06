resource_name :a10_system

property :a10_name, String, name_property: true
property :mgmt_port, Hash
property :src_ip_hash_enable, [true, false]
property :promiscuous_mode, [true, false]
property :control_cpu, Hash
property :tcp, Hash
property :module_ctrl_cpu, ['high','low','medium']
property :bandwidth, Hash
property :session, Hash
property :class_list_hitcount_enable, [true, false]
property :modify_port, Hash
property :all_vlan_limit, Hash
property :del_port, Hash
property :session_reclaim_limit, Hash
property :add_port, Hash
property :attack_log, [true, false]
property :uuid, String
property :bfd, Hash
property :icmp_rate, Hash
property :ddos_attack, [true, false]
property :trunk_xaui_hw_hash, Hash
property :ip_stats, Hash
property :ip6_stats, Hash
property :attack, [true, false]
property :io_cpu, Hash
property :template, Hash
property :memory, Hash
property :resource_accounting, Hash
property :anomaly_log, [true, false]
property :ipmi_service, Hash
property :cpu_hyper_thread, Hash
property :icmp6, Hash
property :data_cpu, Hash
property :trunk_hw_hash, Hash
property :ve_mac_scheme, Hash
property :glid, Integer
property :template_bind, Hash
property :ipmi, Hash
property :ddos_log, [true, false]
property :ndisc_ra, Hash
property :spe_profile, Hash
property :add_cpu_core, Hash
property :trunk, Hash
property :telemetry_log, Hash
property :ipsec, Hash
property :icmp, Hash
property :per_vlan_limit, Hash
property :resource_usage, Hash
property :cpu_load_sharing, Hash
property :hardware_forward, Hash
property :sockstress_disable, [true, false]
property :tcp_stats, Hash
property :delete_cpu_core, Hash
property :log_cpu_interval, Integer
property :throughput, Hash
property :queuing_buffer, Hash
property :cm_update_file_name_ref, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system"
    mgmt_port = new_resource.mgmt_port
    src_ip_hash_enable = new_resource.src_ip_hash_enable
    promiscuous_mode = new_resource.promiscuous_mode
    control_cpu = new_resource.control_cpu
    tcp = new_resource.tcp
    module_ctrl_cpu = new_resource.module_ctrl_cpu
    bandwidth = new_resource.bandwidth
    session = new_resource.session
    class_list_hitcount_enable = new_resource.class_list_hitcount_enable
    modify_port = new_resource.modify_port
    all_vlan_limit = new_resource.all_vlan_limit
    del_port = new_resource.del_port
    session_reclaim_limit = new_resource.session_reclaim_limit
    add_port = new_resource.add_port
    attack_log = new_resource.attack_log
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    icmp_rate = new_resource.icmp_rate
    ddos_attack = new_resource.ddos_attack
    trunk_xaui_hw_hash = new_resource.trunk_xaui_hw_hash
    ip_stats = new_resource.ip_stats
    ip6_stats = new_resource.ip6_stats
    attack = new_resource.attack
    io_cpu = new_resource.io_cpu
    template = new_resource.template
    memory = new_resource.memory
    resource_accounting = new_resource.resource_accounting
    anomaly_log = new_resource.anomaly_log
    ipmi_service = new_resource.ipmi_service
    cpu_hyper_thread = new_resource.cpu_hyper_thread
    icmp6 = new_resource.icmp6
    data_cpu = new_resource.data_cpu
    trunk_hw_hash = new_resource.trunk_hw_hash
    ve_mac_scheme = new_resource.ve_mac_scheme
    glid = new_resource.glid
    template_bind = new_resource.template_bind
    ipmi = new_resource.ipmi
    ddos_log = new_resource.ddos_log
    ndisc_ra = new_resource.ndisc_ra
    spe_profile = new_resource.spe_profile
    add_cpu_core = new_resource.add_cpu_core
    trunk = new_resource.trunk
    telemetry_log = new_resource.telemetry_log
    ipsec = new_resource.ipsec
    icmp = new_resource.icmp
    per_vlan_limit = new_resource.per_vlan_limit
    resource_usage = new_resource.resource_usage
    cpu_load_sharing = new_resource.cpu_load_sharing
    hardware_forward = new_resource.hardware_forward
    sockstress_disable = new_resource.sockstress_disable
    tcp_stats = new_resource.tcp_stats
    delete_cpu_core = new_resource.delete_cpu_core
    log_cpu_interval = new_resource.log_cpu_interval
    throughput = new_resource.throughput
    queuing_buffer = new_resource.queuing_buffer
    cm_update_file_name_ref = new_resource.cm_update_file_name_ref

    params = { "system": {"mgmt-port": mgmt_port,
        "src-ip-hash-enable": src_ip_hash_enable,
        "promiscuous-mode": promiscuous_mode,
        "control-cpu": control_cpu,
        "tcp": tcp,
        "module-ctrl-cpu": module_ctrl_cpu,
        "bandwidth": bandwidth,
        "session": session,
        "class-list-hitcount-enable": class_list_hitcount_enable,
        "modify-port": modify_port,
        "all-vlan-limit": all_vlan_limit,
        "del-port": del_port,
        "session-reclaim-limit": session_reclaim_limit,
        "add-port": add_port,
        "attack-log": attack_log,
        "uuid": uuid,
        "bfd": bfd,
        "icmp-rate": icmp_rate,
        "ddos-attack": ddos_attack,
        "trunk-xaui-hw-hash": trunk_xaui_hw_hash,
        "ip-stats": ip_stats,
        "ip6-stats": ip6_stats,
        "attack": attack,
        "io-cpu": io_cpu,
        "template": template,
        "memory": memory,
        "resource-accounting": resource_accounting,
        "anomaly-log": anomaly_log,
        "ipmi-service": ipmi_service,
        "cpu-hyper-thread": cpu_hyper_thread,
        "icmp6": icmp6,
        "data-cpu": data_cpu,
        "trunk-hw-hash": trunk_hw_hash,
        "ve-mac-scheme": ve_mac_scheme,
        "glid": glid,
        "template-bind": template_bind,
        "ipmi": ipmi,
        "ddos-log": ddos_log,
        "ndisc-ra": ndisc_ra,
        "spe-profile": spe_profile,
        "add-cpu-core": add_cpu_core,
        "trunk": trunk,
        "telemetry-log": telemetry_log,
        "ipsec": ipsec,
        "icmp": icmp,
        "per-vlan-limit": per_vlan_limit,
        "resource-usage": resource_usage,
        "cpu-load-sharing": cpu_load_sharing,
        "hardware-forward": hardware_forward,
        "sockstress-disable": sockstress_disable,
        "tcp-stats": tcp_stats,
        "delete-cpu-core": delete_cpu_core,
        "log-cpu-interval": log_cpu_interval,
        "throughput": throughput,
        "queuing-buffer": queuing_buffer,
        "cm-update-file-name-ref": cm_update_file_name_ref,} }

    params[:"system"].each do |k, v|
        if not v 
            params[:"system"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system"
    mgmt_port = new_resource.mgmt_port
    src_ip_hash_enable = new_resource.src_ip_hash_enable
    promiscuous_mode = new_resource.promiscuous_mode
    control_cpu = new_resource.control_cpu
    tcp = new_resource.tcp
    module_ctrl_cpu = new_resource.module_ctrl_cpu
    bandwidth = new_resource.bandwidth
    session = new_resource.session
    class_list_hitcount_enable = new_resource.class_list_hitcount_enable
    modify_port = new_resource.modify_port
    all_vlan_limit = new_resource.all_vlan_limit
    del_port = new_resource.del_port
    session_reclaim_limit = new_resource.session_reclaim_limit
    add_port = new_resource.add_port
    attack_log = new_resource.attack_log
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    icmp_rate = new_resource.icmp_rate
    ddos_attack = new_resource.ddos_attack
    trunk_xaui_hw_hash = new_resource.trunk_xaui_hw_hash
    ip_stats = new_resource.ip_stats
    ip6_stats = new_resource.ip6_stats
    attack = new_resource.attack
    io_cpu = new_resource.io_cpu
    template = new_resource.template
    memory = new_resource.memory
    resource_accounting = new_resource.resource_accounting
    anomaly_log = new_resource.anomaly_log
    ipmi_service = new_resource.ipmi_service
    cpu_hyper_thread = new_resource.cpu_hyper_thread
    icmp6 = new_resource.icmp6
    data_cpu = new_resource.data_cpu
    trunk_hw_hash = new_resource.trunk_hw_hash
    ve_mac_scheme = new_resource.ve_mac_scheme
    glid = new_resource.glid
    template_bind = new_resource.template_bind
    ipmi = new_resource.ipmi
    ddos_log = new_resource.ddos_log
    ndisc_ra = new_resource.ndisc_ra
    spe_profile = new_resource.spe_profile
    add_cpu_core = new_resource.add_cpu_core
    trunk = new_resource.trunk
    telemetry_log = new_resource.telemetry_log
    ipsec = new_resource.ipsec
    icmp = new_resource.icmp
    per_vlan_limit = new_resource.per_vlan_limit
    resource_usage = new_resource.resource_usage
    cpu_load_sharing = new_resource.cpu_load_sharing
    hardware_forward = new_resource.hardware_forward
    sockstress_disable = new_resource.sockstress_disable
    tcp_stats = new_resource.tcp_stats
    delete_cpu_core = new_resource.delete_cpu_core
    log_cpu_interval = new_resource.log_cpu_interval
    throughput = new_resource.throughput
    queuing_buffer = new_resource.queuing_buffer
    cm_update_file_name_ref = new_resource.cm_update_file_name_ref

    params = { "system": {"mgmt-port": mgmt_port,
        "src-ip-hash-enable": src_ip_hash_enable,
        "promiscuous-mode": promiscuous_mode,
        "control-cpu": control_cpu,
        "tcp": tcp,
        "module-ctrl-cpu": module_ctrl_cpu,
        "bandwidth": bandwidth,
        "session": session,
        "class-list-hitcount-enable": class_list_hitcount_enable,
        "modify-port": modify_port,
        "all-vlan-limit": all_vlan_limit,
        "del-port": del_port,
        "session-reclaim-limit": session_reclaim_limit,
        "add-port": add_port,
        "attack-log": attack_log,
        "uuid": uuid,
        "bfd": bfd,
        "icmp-rate": icmp_rate,
        "ddos-attack": ddos_attack,
        "trunk-xaui-hw-hash": trunk_xaui_hw_hash,
        "ip-stats": ip_stats,
        "ip6-stats": ip6_stats,
        "attack": attack,
        "io-cpu": io_cpu,
        "template": template,
        "memory": memory,
        "resource-accounting": resource_accounting,
        "anomaly-log": anomaly_log,
        "ipmi-service": ipmi_service,
        "cpu-hyper-thread": cpu_hyper_thread,
        "icmp6": icmp6,
        "data-cpu": data_cpu,
        "trunk-hw-hash": trunk_hw_hash,
        "ve-mac-scheme": ve_mac_scheme,
        "glid": glid,
        "template-bind": template_bind,
        "ipmi": ipmi,
        "ddos-log": ddos_log,
        "ndisc-ra": ndisc_ra,
        "spe-profile": spe_profile,
        "add-cpu-core": add_cpu_core,
        "trunk": trunk,
        "telemetry-log": telemetry_log,
        "ipsec": ipsec,
        "icmp": icmp,
        "per-vlan-limit": per_vlan_limit,
        "resource-usage": resource_usage,
        "cpu-load-sharing": cpu_load_sharing,
        "hardware-forward": hardware_forward,
        "sockstress-disable": sockstress_disable,
        "tcp-stats": tcp_stats,
        "delete-cpu-core": delete_cpu_core,
        "log-cpu-interval": log_cpu_interval,
        "throughput": throughput,
        "queuing-buffer": queuing_buffer,
        "cm-update-file-name-ref": cm_update_file_name_ref,} }

    params[:"system"].each do |k, v|
        if not v
            params[:"system"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system"].each do |k, v|
        if v != params[:"system"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system') do
            client.delete(url)
        end
    end
end