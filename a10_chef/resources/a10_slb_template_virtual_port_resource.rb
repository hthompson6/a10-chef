resource_name :a10_slb_template_virtual_port

property :a10_name, String, name_property: true
property :reset_unknown_conn, [true, false]
property :ignore_tcp_msl, [true, false]
property :rate, Integer
property :snat_msl, Integer
property :allow_syn_otherflags, [true, false]
property :aflow, [true, false]
property :conn_limit, Integer
property :drop_unknown_conn, [true, false]
property :uuid, String
property :reset_l7_on_failover, [true, false]
property :pkt_rate_type, ['src-ip-port','src-port']
property :rate_interval, ['100ms','second']
property :snat_port_preserve, [true, false]
property :conn_rate_limit_reset, [true, false]
property :when_rr_enable, [true, false]
property :non_syn_initiation, [true, false]
property :conn_limit_reset, [true, false]
property :dscp, Integer
property :pkt_rate_limit_reset, Integer
property :conn_limit_no_logging, [true, false]
property :conn_rate_limit_no_logging, [true, false]
property :log_options, ['no-logging','no-repeat-logging']
property :allow_vip_to_rport_mapping, [true, false]
property :pkt_rate_interval, ['100ms','second']
property :user_tag, String
property :conn_rate_limit, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/virtual-port/"
    get_url = "/axapi/v3/slb/template/virtual-port/%<name>s"
    reset_unknown_conn = new_resource.reset_unknown_conn
    ignore_tcp_msl = new_resource.ignore_tcp_msl
    rate = new_resource.rate
    snat_msl = new_resource.snat_msl
    allow_syn_otherflags = new_resource.allow_syn_otherflags
    aflow = new_resource.aflow
    conn_limit = new_resource.conn_limit
    drop_unknown_conn = new_resource.drop_unknown_conn
    uuid = new_resource.uuid
    reset_l7_on_failover = new_resource.reset_l7_on_failover
    pkt_rate_type = new_resource.pkt_rate_type
    rate_interval = new_resource.rate_interval
    snat_port_preserve = new_resource.snat_port_preserve
    conn_rate_limit_reset = new_resource.conn_rate_limit_reset
    when_rr_enable = new_resource.when_rr_enable
    non_syn_initiation = new_resource.non_syn_initiation
    conn_limit_reset = new_resource.conn_limit_reset
    dscp = new_resource.dscp
    pkt_rate_limit_reset = new_resource.pkt_rate_limit_reset
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    log_options = new_resource.log_options
    a10_name = new_resource.a10_name
    allow_vip_to_rport_mapping = new_resource.allow_vip_to_rport_mapping
    pkt_rate_interval = new_resource.pkt_rate_interval
    user_tag = new_resource.user_tag
    conn_rate_limit = new_resource.conn_rate_limit

    params = { "virtual-port": {"reset-unknown-conn": reset_unknown_conn,
        "ignore-tcp-msl": ignore_tcp_msl,
        "rate": rate,
        "snat-msl": snat_msl,
        "allow-syn-otherflags": allow_syn_otherflags,
        "aflow": aflow,
        "conn-limit": conn_limit,
        "drop-unknown-conn": drop_unknown_conn,
        "uuid": uuid,
        "reset-l7-on-failover": reset_l7_on_failover,
        "pkt-rate-type": pkt_rate_type,
        "rate-interval": rate_interval,
        "snat-port-preserve": snat_port_preserve,
        "conn-rate-limit-reset": conn_rate_limit_reset,
        "when-rr-enable": when_rr_enable,
        "non-syn-initiation": non_syn_initiation,
        "conn-limit-reset": conn_limit_reset,
        "dscp": dscp,
        "pkt-rate-limit-reset": pkt_rate_limit_reset,
        "conn-limit-no-logging": conn_limit_no_logging,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "log-options": log_options,
        "name": a10_name,
        "allow-vip-to-rport-mapping": allow_vip_to_rport_mapping,
        "pkt-rate-interval": pkt_rate_interval,
        "user-tag": user_tag,
        "conn-rate-limit": conn_rate_limit,} }

    params[:"virtual-port"].each do |k, v|
        if not v 
            params[:"virtual-port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating virtual-port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/virtual-port/%<name>s"
    reset_unknown_conn = new_resource.reset_unknown_conn
    ignore_tcp_msl = new_resource.ignore_tcp_msl
    rate = new_resource.rate
    snat_msl = new_resource.snat_msl
    allow_syn_otherflags = new_resource.allow_syn_otherflags
    aflow = new_resource.aflow
    conn_limit = new_resource.conn_limit
    drop_unknown_conn = new_resource.drop_unknown_conn
    uuid = new_resource.uuid
    reset_l7_on_failover = new_resource.reset_l7_on_failover
    pkt_rate_type = new_resource.pkt_rate_type
    rate_interval = new_resource.rate_interval
    snat_port_preserve = new_resource.snat_port_preserve
    conn_rate_limit_reset = new_resource.conn_rate_limit_reset
    when_rr_enable = new_resource.when_rr_enable
    non_syn_initiation = new_resource.non_syn_initiation
    conn_limit_reset = new_resource.conn_limit_reset
    dscp = new_resource.dscp
    pkt_rate_limit_reset = new_resource.pkt_rate_limit_reset
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    log_options = new_resource.log_options
    a10_name = new_resource.a10_name
    allow_vip_to_rport_mapping = new_resource.allow_vip_to_rport_mapping
    pkt_rate_interval = new_resource.pkt_rate_interval
    user_tag = new_resource.user_tag
    conn_rate_limit = new_resource.conn_rate_limit

    params = { "virtual-port": {"reset-unknown-conn": reset_unknown_conn,
        "ignore-tcp-msl": ignore_tcp_msl,
        "rate": rate,
        "snat-msl": snat_msl,
        "allow-syn-otherflags": allow_syn_otherflags,
        "aflow": aflow,
        "conn-limit": conn_limit,
        "drop-unknown-conn": drop_unknown_conn,
        "uuid": uuid,
        "reset-l7-on-failover": reset_l7_on_failover,
        "pkt-rate-type": pkt_rate_type,
        "rate-interval": rate_interval,
        "snat-port-preserve": snat_port_preserve,
        "conn-rate-limit-reset": conn_rate_limit_reset,
        "when-rr-enable": when_rr_enable,
        "non-syn-initiation": non_syn_initiation,
        "conn-limit-reset": conn_limit_reset,
        "dscp": dscp,
        "pkt-rate-limit-reset": pkt_rate_limit_reset,
        "conn-limit-no-logging": conn_limit_no_logging,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "log-options": log_options,
        "name": a10_name,
        "allow-vip-to-rport-mapping": allow_vip_to_rport_mapping,
        "pkt-rate-interval": pkt_rate_interval,
        "user-tag": user_tag,
        "conn-rate-limit": conn_rate_limit,} }

    params[:"virtual-port"].each do |k, v|
        if not v
            params[:"virtual-port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["virtual-port"].each do |k, v|
        if v != params[:"virtual-port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating virtual-port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/virtual-port/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting virtual-port') do
            client.delete(url)
        end
    end
end