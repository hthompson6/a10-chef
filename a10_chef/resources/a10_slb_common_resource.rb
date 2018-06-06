resource_name :a10_slb_common

property :a10_name, String, name_property: true
property :low_latency, [true, false]
property :use_mss_tab, [true, false]
property :stats_data_disable, [true, false]
property :compress_block_size, Integer
property :player_id_check_enable, [true, false]
property :dns_cache_enable, [true, false]
property :msl_time, Integer
property :graceful_shutdown_enable, [true, false]
property :buff_thresh_hw_buff, Integer
property :hw_syn_rr, Integer
property :entity, ['server','virtual-server']
property :reset_stale_session, [true, false]
property :gateway_health_check, [true, false]
property :scale_out, [true, false]
property :graceful_shutdown, Integer
property :rate_limit_logging, [true, false]
property :fast_path_disable, [true, false]
property :drop_icmp_to_vip_when_vip_down, [true, false]
property :ssli_sni_hash_enable, [true, false]
property :hw_compression, [true, false]
property :dns_vip_stateless, [true, false]
property :buff_thresh_sys_buff_low, Integer
property :range_end, Integer
property :after_disable, [true, false]
property :max_local_rate, Integer
property :exclude_destination, ['local','remote']
property :dns_cache_age, Integer
property :max_http_header_count, Integer
property :l2l3_trunk_lb_disable, [true, false]
property :sort_res, [true, false]
property :snat_gwy_for_l3, [true, false]
property :buff_thresh_relieve_thresh, Integer
property :dsr_health_check_enable, [true, false]
property :buff_thresh, [true, false]
property :dns_cache_entry_size, Integer
property :log_for_reset_unknown_conn, [true, false]
property :auto_nat_no_ip_refresh, ['enable','disable']
property :pkt_rate_for_reset_unknown_conn, Integer
property :buff_thresh_sys_buff_high, Integer
property :max_buff_queued_per_conn, Integer
property :max_remote_rate, Integer
property :ttl_threshold, Integer
property :extended_stats, [true, false]
property :enable_l7_req_acct, [true, false]
property :uuid, String
property :snat_on_vip, [true, false]
property :range_start, Integer
property :honor_server_response_ttl, [true, false]
property :interval, Integer
property :stateless_sg_multi_binding, [true, false]
property :disable_adaptive_resource_check, [true, false]
property :range, Integer
property :conn_rate_limit, Hash
property :mss_table, Integer
property :timeout, Integer
property :response_type, ['single-answer','round-robin']
property :ddos_protection, Hash
property :override_port, [true, false]
property :no_auto_up_on_aflex, [true, false]
property :disable_server_auto_reselect, [true, false]
property :software, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/common"
    low_latency = new_resource.low_latency
    use_mss_tab = new_resource.use_mss_tab
    stats_data_disable = new_resource.stats_data_disable
    compress_block_size = new_resource.compress_block_size
    player_id_check_enable = new_resource.player_id_check_enable
    dns_cache_enable = new_resource.dns_cache_enable
    msl_time = new_resource.msl_time
    graceful_shutdown_enable = new_resource.graceful_shutdown_enable
    buff_thresh_hw_buff = new_resource.buff_thresh_hw_buff
    hw_syn_rr = new_resource.hw_syn_rr
    entity = new_resource.entity
    reset_stale_session = new_resource.reset_stale_session
    gateway_health_check = new_resource.gateway_health_check
    scale_out = new_resource.scale_out
    graceful_shutdown = new_resource.graceful_shutdown
    rate_limit_logging = new_resource.rate_limit_logging
    fast_path_disable = new_resource.fast_path_disable
    drop_icmp_to_vip_when_vip_down = new_resource.drop_icmp_to_vip_when_vip_down
    ssli_sni_hash_enable = new_resource.ssli_sni_hash_enable
    hw_compression = new_resource.hw_compression
    dns_vip_stateless = new_resource.dns_vip_stateless
    buff_thresh_sys_buff_low = new_resource.buff_thresh_sys_buff_low
    range_end = new_resource.range_end
    after_disable = new_resource.after_disable
    max_local_rate = new_resource.max_local_rate
    exclude_destination = new_resource.exclude_destination
    dns_cache_age = new_resource.dns_cache_age
    max_http_header_count = new_resource.max_http_header_count
    l2l3_trunk_lb_disable = new_resource.l2l3_trunk_lb_disable
    sort_res = new_resource.sort_res
    snat_gwy_for_l3 = new_resource.snat_gwy_for_l3
    buff_thresh_relieve_thresh = new_resource.buff_thresh_relieve_thresh
    dsr_health_check_enable = new_resource.dsr_health_check_enable
    buff_thresh = new_resource.buff_thresh
    dns_cache_entry_size = new_resource.dns_cache_entry_size
    log_for_reset_unknown_conn = new_resource.log_for_reset_unknown_conn
    auto_nat_no_ip_refresh = new_resource.auto_nat_no_ip_refresh
    pkt_rate_for_reset_unknown_conn = new_resource.pkt_rate_for_reset_unknown_conn
    buff_thresh_sys_buff_high = new_resource.buff_thresh_sys_buff_high
    max_buff_queued_per_conn = new_resource.max_buff_queued_per_conn
    max_remote_rate = new_resource.max_remote_rate
    ttl_threshold = new_resource.ttl_threshold
    extended_stats = new_resource.extended_stats
    enable_l7_req_acct = new_resource.enable_l7_req_acct
    uuid = new_resource.uuid
    snat_on_vip = new_resource.snat_on_vip
    range_start = new_resource.range_start
    honor_server_response_ttl = new_resource.honor_server_response_ttl
    interval = new_resource.interval
    stateless_sg_multi_binding = new_resource.stateless_sg_multi_binding
    disable_adaptive_resource_check = new_resource.disable_adaptive_resource_check
    range = new_resource.range
    conn_rate_limit = new_resource.conn_rate_limit
    mss_table = new_resource.mss_table
    timeout = new_resource.timeout
    response_type = new_resource.response_type
    ddos_protection = new_resource.ddos_protection
    override_port = new_resource.override_port
    no_auto_up_on_aflex = new_resource.no_auto_up_on_aflex
    disable_server_auto_reselect = new_resource.disable_server_auto_reselect
    software = new_resource.software

    params = { "common": {"low-latency": low_latency,
        "use-mss-tab": use_mss_tab,
        "stats-data-disable": stats_data_disable,
        "compress-block-size": compress_block_size,
        "player-id-check-enable": player_id_check_enable,
        "dns-cache-enable": dns_cache_enable,
        "msl-time": msl_time,
        "graceful-shutdown-enable": graceful_shutdown_enable,
        "buff-thresh-hw-buff": buff_thresh_hw_buff,
        "hw-syn-rr": hw_syn_rr,
        "entity": entity,
        "reset-stale-session": reset_stale_session,
        "gateway-health-check": gateway_health_check,
        "scale-out": scale_out,
        "graceful-shutdown": graceful_shutdown,
        "rate-limit-logging": rate_limit_logging,
        "fast-path-disable": fast_path_disable,
        "drop-icmp-to-vip-when-vip-down": drop_icmp_to_vip_when_vip_down,
        "ssli-sni-hash-enable": ssli_sni_hash_enable,
        "hw-compression": hw_compression,
        "dns-vip-stateless": dns_vip_stateless,
        "buff-thresh-sys-buff-low": buff_thresh_sys_buff_low,
        "range-end": range_end,
        "after-disable": after_disable,
        "max-local-rate": max_local_rate,
        "exclude-destination": exclude_destination,
        "dns-cache-age": dns_cache_age,
        "max-http-header-count": max_http_header_count,
        "l2l3-trunk-lb-disable": l2l3_trunk_lb_disable,
        "sort-res": sort_res,
        "snat-gwy-for-l3": snat_gwy_for_l3,
        "buff-thresh-relieve-thresh": buff_thresh_relieve_thresh,
        "dsr-health-check-enable": dsr_health_check_enable,
        "buff-thresh": buff_thresh,
        "dns-cache-entry-size": dns_cache_entry_size,
        "log-for-reset-unknown-conn": log_for_reset_unknown_conn,
        "auto-nat-no-ip-refresh": auto_nat_no_ip_refresh,
        "pkt-rate-for-reset-unknown-conn": pkt_rate_for_reset_unknown_conn,
        "buff-thresh-sys-buff-high": buff_thresh_sys_buff_high,
        "max-buff-queued-per-conn": max_buff_queued_per_conn,
        "max-remote-rate": max_remote_rate,
        "ttl-threshold": ttl_threshold,
        "extended-stats": extended_stats,
        "enable-l7-req-acct": enable_l7_req_acct,
        "uuid": uuid,
        "snat-on-vip": snat_on_vip,
        "range-start": range_start,
        "honor-server-response-ttl": honor_server_response_ttl,
        "interval": interval,
        "stateless-sg-multi-binding": stateless_sg_multi_binding,
        "disable-adaptive-resource-check": disable_adaptive_resource_check,
        "range": range,
        "conn-rate-limit": conn_rate_limit,
        "mss-table": mss_table,
        "timeout": timeout,
        "response-type": response_type,
        "ddos-protection": ddos_protection,
        "override-port": override_port,
        "no-auto-up-on-aflex": no_auto_up_on_aflex,
        "disable-server-auto-reselect": disable_server_auto_reselect,
        "software": software,} }

    params[:"common"].each do |k, v|
        if not v 
            params[:"common"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating common') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/common"
    low_latency = new_resource.low_latency
    use_mss_tab = new_resource.use_mss_tab
    stats_data_disable = new_resource.stats_data_disable
    compress_block_size = new_resource.compress_block_size
    player_id_check_enable = new_resource.player_id_check_enable
    dns_cache_enable = new_resource.dns_cache_enable
    msl_time = new_resource.msl_time
    graceful_shutdown_enable = new_resource.graceful_shutdown_enable
    buff_thresh_hw_buff = new_resource.buff_thresh_hw_buff
    hw_syn_rr = new_resource.hw_syn_rr
    entity = new_resource.entity
    reset_stale_session = new_resource.reset_stale_session
    gateway_health_check = new_resource.gateway_health_check
    scale_out = new_resource.scale_out
    graceful_shutdown = new_resource.graceful_shutdown
    rate_limit_logging = new_resource.rate_limit_logging
    fast_path_disable = new_resource.fast_path_disable
    drop_icmp_to_vip_when_vip_down = new_resource.drop_icmp_to_vip_when_vip_down
    ssli_sni_hash_enable = new_resource.ssli_sni_hash_enable
    hw_compression = new_resource.hw_compression
    dns_vip_stateless = new_resource.dns_vip_stateless
    buff_thresh_sys_buff_low = new_resource.buff_thresh_sys_buff_low
    range_end = new_resource.range_end
    after_disable = new_resource.after_disable
    max_local_rate = new_resource.max_local_rate
    exclude_destination = new_resource.exclude_destination
    dns_cache_age = new_resource.dns_cache_age
    max_http_header_count = new_resource.max_http_header_count
    l2l3_trunk_lb_disable = new_resource.l2l3_trunk_lb_disable
    sort_res = new_resource.sort_res
    snat_gwy_for_l3 = new_resource.snat_gwy_for_l3
    buff_thresh_relieve_thresh = new_resource.buff_thresh_relieve_thresh
    dsr_health_check_enable = new_resource.dsr_health_check_enable
    buff_thresh = new_resource.buff_thresh
    dns_cache_entry_size = new_resource.dns_cache_entry_size
    log_for_reset_unknown_conn = new_resource.log_for_reset_unknown_conn
    auto_nat_no_ip_refresh = new_resource.auto_nat_no_ip_refresh
    pkt_rate_for_reset_unknown_conn = new_resource.pkt_rate_for_reset_unknown_conn
    buff_thresh_sys_buff_high = new_resource.buff_thresh_sys_buff_high
    max_buff_queued_per_conn = new_resource.max_buff_queued_per_conn
    max_remote_rate = new_resource.max_remote_rate
    ttl_threshold = new_resource.ttl_threshold
    extended_stats = new_resource.extended_stats
    enable_l7_req_acct = new_resource.enable_l7_req_acct
    uuid = new_resource.uuid
    snat_on_vip = new_resource.snat_on_vip
    range_start = new_resource.range_start
    honor_server_response_ttl = new_resource.honor_server_response_ttl
    interval = new_resource.interval
    stateless_sg_multi_binding = new_resource.stateless_sg_multi_binding
    disable_adaptive_resource_check = new_resource.disable_adaptive_resource_check
    range = new_resource.range
    conn_rate_limit = new_resource.conn_rate_limit
    mss_table = new_resource.mss_table
    timeout = new_resource.timeout
    response_type = new_resource.response_type
    ddos_protection = new_resource.ddos_protection
    override_port = new_resource.override_port
    no_auto_up_on_aflex = new_resource.no_auto_up_on_aflex
    disable_server_auto_reselect = new_resource.disable_server_auto_reselect
    software = new_resource.software

    params = { "common": {"low-latency": low_latency,
        "use-mss-tab": use_mss_tab,
        "stats-data-disable": stats_data_disable,
        "compress-block-size": compress_block_size,
        "player-id-check-enable": player_id_check_enable,
        "dns-cache-enable": dns_cache_enable,
        "msl-time": msl_time,
        "graceful-shutdown-enable": graceful_shutdown_enable,
        "buff-thresh-hw-buff": buff_thresh_hw_buff,
        "hw-syn-rr": hw_syn_rr,
        "entity": entity,
        "reset-stale-session": reset_stale_session,
        "gateway-health-check": gateway_health_check,
        "scale-out": scale_out,
        "graceful-shutdown": graceful_shutdown,
        "rate-limit-logging": rate_limit_logging,
        "fast-path-disable": fast_path_disable,
        "drop-icmp-to-vip-when-vip-down": drop_icmp_to_vip_when_vip_down,
        "ssli-sni-hash-enable": ssli_sni_hash_enable,
        "hw-compression": hw_compression,
        "dns-vip-stateless": dns_vip_stateless,
        "buff-thresh-sys-buff-low": buff_thresh_sys_buff_low,
        "range-end": range_end,
        "after-disable": after_disable,
        "max-local-rate": max_local_rate,
        "exclude-destination": exclude_destination,
        "dns-cache-age": dns_cache_age,
        "max-http-header-count": max_http_header_count,
        "l2l3-trunk-lb-disable": l2l3_trunk_lb_disable,
        "sort-res": sort_res,
        "snat-gwy-for-l3": snat_gwy_for_l3,
        "buff-thresh-relieve-thresh": buff_thresh_relieve_thresh,
        "dsr-health-check-enable": dsr_health_check_enable,
        "buff-thresh": buff_thresh,
        "dns-cache-entry-size": dns_cache_entry_size,
        "log-for-reset-unknown-conn": log_for_reset_unknown_conn,
        "auto-nat-no-ip-refresh": auto_nat_no_ip_refresh,
        "pkt-rate-for-reset-unknown-conn": pkt_rate_for_reset_unknown_conn,
        "buff-thresh-sys-buff-high": buff_thresh_sys_buff_high,
        "max-buff-queued-per-conn": max_buff_queued_per_conn,
        "max-remote-rate": max_remote_rate,
        "ttl-threshold": ttl_threshold,
        "extended-stats": extended_stats,
        "enable-l7-req-acct": enable_l7_req_acct,
        "uuid": uuid,
        "snat-on-vip": snat_on_vip,
        "range-start": range_start,
        "honor-server-response-ttl": honor_server_response_ttl,
        "interval": interval,
        "stateless-sg-multi-binding": stateless_sg_multi_binding,
        "disable-adaptive-resource-check": disable_adaptive_resource_check,
        "range": range,
        "conn-rate-limit": conn_rate_limit,
        "mss-table": mss_table,
        "timeout": timeout,
        "response-type": response_type,
        "ddos-protection": ddos_protection,
        "override-port": override_port,
        "no-auto-up-on-aflex": no_auto_up_on_aflex,
        "disable-server-auto-reselect": disable_server_auto_reselect,
        "software": software,} }

    params[:"common"].each do |k, v|
        if not v
            params[:"common"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["common"].each do |k, v|
        if v != params[:"common"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating common') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/common"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting common') do
            client.delete(url)
        end
    end
end