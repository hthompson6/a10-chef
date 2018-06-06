resource_name :a10_rule_set_rule

property :a10_name, String, name_property: true
property :cgnv6_fixed_nat_log, [true, false]
property :forward_listen_on_port, [true, false]
property :service_any, ['any']
property :app_list, Array
property :src_threat_list, String
property :cgnv6_policy, ['lsn-lid','fixed-nat','static-nat']
property :cgnv6_log, [true, false]
property :forward_log, [true, false]
property :cgnv6_lsn_log, [true, false]
property :listen_on_port, [true, false]
property :move_rule, Hash
property :uuid, String
property :idle_timeout, Integer
property :fwlog, [true, false]
property :src_zone_any, ['any']
property :ip_version, ['v4','v6']
property :application_any, ['any']
property :a10_action, ['permit','deny','reset']
property :policy, ['cgnv6','forward']
property :source_list, Array
property :dst_zone_any, ['any']
property :status, ['enable','disable']
property :dst_ipv4_any, ['any']
property :src_zone, String
property :src_ipv4_any, ['any']
property :log, [true, false]
property :dst_zone, String
property :dst_class_list, String
property :src_ipv6_any, ['any']
property :dst_threat_list, String
property :remark, String
property :src_class_list, String
property :cgnv6_lsn_lid, Integer
property :track_application, [true, false]
property :user_tag, String
property :dst_ipv6_any, ['any']
property :sampling_enable, Array
property :service_list, Array
property :dest_list, Array
property :fw_log, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rule-set/%<name>s/rule/"
    get_url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s"
    cgnv6_fixed_nat_log = new_resource.cgnv6_fixed_nat_log
    forward_listen_on_port = new_resource.forward_listen_on_port
    service_any = new_resource.service_any
    app_list = new_resource.app_list
    src_threat_list = new_resource.src_threat_list
    cgnv6_policy = new_resource.cgnv6_policy
    cgnv6_log = new_resource.cgnv6_log
    forward_log = new_resource.forward_log
    cgnv6_lsn_log = new_resource.cgnv6_lsn_log
    listen_on_port = new_resource.listen_on_port
    move_rule = new_resource.move_rule
    uuid = new_resource.uuid
    idle_timeout = new_resource.idle_timeout
    fwlog = new_resource.fwlog
    src_zone_any = new_resource.src_zone_any
    ip_version = new_resource.ip_version
    application_any = new_resource.application_any
    a10_name = new_resource.a10_name
    policy = new_resource.policy
    source_list = new_resource.source_list
    dst_zone_any = new_resource.dst_zone_any
    status = new_resource.status
    dst_ipv4_any = new_resource.dst_ipv4_any
    src_zone = new_resource.src_zone
    src_ipv4_any = new_resource.src_ipv4_any
    log = new_resource.log
    dst_zone = new_resource.dst_zone
    dst_class_list = new_resource.dst_class_list
    src_ipv6_any = new_resource.src_ipv6_any
    dst_threat_list = new_resource.dst_threat_list
    remark = new_resource.remark
    src_class_list = new_resource.src_class_list
    a10_name = new_resource.a10_name
    cgnv6_lsn_lid = new_resource.cgnv6_lsn_lid
    track_application = new_resource.track_application
    user_tag = new_resource.user_tag
    dst_ipv6_any = new_resource.dst_ipv6_any
    sampling_enable = new_resource.sampling_enable
    service_list = new_resource.service_list
    dest_list = new_resource.dest_list
    fw_log = new_resource.fw_log

    params = { "rule": {"cgnv6-fixed-nat-log": cgnv6_fixed_nat_log,
        "forward-listen-on-port": forward_listen_on_port,
        "service-any": service_any,
        "app-list": app_list,
        "src-threat-list": src_threat_list,
        "cgnv6-policy": cgnv6_policy,
        "cgnv6-log": cgnv6_log,
        "forward-log": forward_log,
        "cgnv6-lsn-log": cgnv6_lsn_log,
        "listen-on-port": listen_on_port,
        "move-rule": move_rule,
        "uuid": uuid,
        "idle-timeout": idle_timeout,
        "fwlog": fwlog,
        "src-zone-any": src_zone_any,
        "ip-version": ip_version,
        "application-any": application_any,
        "action": a10_action,
        "policy": policy,
        "source-list": source_list,
        "dst-zone-any": dst_zone_any,
        "status": status,
        "dst-ipv4-any": dst_ipv4_any,
        "src-zone": src_zone,
        "src-ipv4-any": src_ipv4_any,
        "log": log,
        "dst-zone": dst_zone,
        "dst-class-list": dst_class_list,
        "src-ipv6-any": src_ipv6_any,
        "dst-threat-list": dst_threat_list,
        "remark": remark,
        "src-class-list": src_class_list,
        "name": a10_name,
        "cgnv6-lsn-lid": cgnv6_lsn_lid,
        "track-application": track_application,
        "user-tag": user_tag,
        "dst-ipv6-any": dst_ipv6_any,
        "sampling-enable": sampling_enable,
        "service-list": service_list,
        "dest-list": dest_list,
        "fw-log": fw_log,} }

    params[:"rule"].each do |k, v|
        if not v 
            params[:"rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s"
    cgnv6_fixed_nat_log = new_resource.cgnv6_fixed_nat_log
    forward_listen_on_port = new_resource.forward_listen_on_port
    service_any = new_resource.service_any
    app_list = new_resource.app_list
    src_threat_list = new_resource.src_threat_list
    cgnv6_policy = new_resource.cgnv6_policy
    cgnv6_log = new_resource.cgnv6_log
    forward_log = new_resource.forward_log
    cgnv6_lsn_log = new_resource.cgnv6_lsn_log
    listen_on_port = new_resource.listen_on_port
    move_rule = new_resource.move_rule
    uuid = new_resource.uuid
    idle_timeout = new_resource.idle_timeout
    fwlog = new_resource.fwlog
    src_zone_any = new_resource.src_zone_any
    ip_version = new_resource.ip_version
    application_any = new_resource.application_any
    a10_name = new_resource.a10_name
    policy = new_resource.policy
    source_list = new_resource.source_list
    dst_zone_any = new_resource.dst_zone_any
    status = new_resource.status
    dst_ipv4_any = new_resource.dst_ipv4_any
    src_zone = new_resource.src_zone
    src_ipv4_any = new_resource.src_ipv4_any
    log = new_resource.log
    dst_zone = new_resource.dst_zone
    dst_class_list = new_resource.dst_class_list
    src_ipv6_any = new_resource.src_ipv6_any
    dst_threat_list = new_resource.dst_threat_list
    remark = new_resource.remark
    src_class_list = new_resource.src_class_list
    a10_name = new_resource.a10_name
    cgnv6_lsn_lid = new_resource.cgnv6_lsn_lid
    track_application = new_resource.track_application
    user_tag = new_resource.user_tag
    dst_ipv6_any = new_resource.dst_ipv6_any
    sampling_enable = new_resource.sampling_enable
    service_list = new_resource.service_list
    dest_list = new_resource.dest_list
    fw_log = new_resource.fw_log

    params = { "rule": {"cgnv6-fixed-nat-log": cgnv6_fixed_nat_log,
        "forward-listen-on-port": forward_listen_on_port,
        "service-any": service_any,
        "app-list": app_list,
        "src-threat-list": src_threat_list,
        "cgnv6-policy": cgnv6_policy,
        "cgnv6-log": cgnv6_log,
        "forward-log": forward_log,
        "cgnv6-lsn-log": cgnv6_lsn_log,
        "listen-on-port": listen_on_port,
        "move-rule": move_rule,
        "uuid": uuid,
        "idle-timeout": idle_timeout,
        "fwlog": fwlog,
        "src-zone-any": src_zone_any,
        "ip-version": ip_version,
        "application-any": application_any,
        "action": a10_action,
        "policy": policy,
        "source-list": source_list,
        "dst-zone-any": dst_zone_any,
        "status": status,
        "dst-ipv4-any": dst_ipv4_any,
        "src-zone": src_zone,
        "src-ipv4-any": src_ipv4_any,
        "log": log,
        "dst-zone": dst_zone,
        "dst-class-list": dst_class_list,
        "src-ipv6-any": src_ipv6_any,
        "dst-threat-list": dst_threat_list,
        "remark": remark,
        "src-class-list": src_class_list,
        "name": a10_name,
        "cgnv6-lsn-lid": cgnv6_lsn_lid,
        "track-application": track_application,
        "user-tag": user_tag,
        "dst-ipv6-any": dst_ipv6_any,
        "sampling-enable": sampling_enable,
        "service-list": service_list,
        "dest-list": dest_list,
        "fw-log": fw_log,} }

    params[:"rule"].each do |k, v|
        if not v
            params[:"rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rule"].each do |k, v|
        if v != params[:"rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s/rule/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rule') do
            client.delete(url)
        end
    end
end