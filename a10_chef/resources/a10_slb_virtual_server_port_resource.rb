resource_name :a10_slb_virtual_server_port

property :a10_name, String, name_property: true
property :ha_conn_mirror, [true, false]
property :protocol, ['tcp','udp','others','diameter','dns-tcp','dns-udp','fast-http','fix','ftp','ftp-proxy','http','https','http2','http2s','imap','mlb','mms','mysql','mssql','pop3','radius','rtsp','sip','sip-tcp','sips','smpp-tcp','spdy','spdys','smtp','ssl-proxy','ssli','tcp-proxy','tftp','fast-fix'],required: true
property :precedence, [true, false]
property :port_translation, [true, false]
property :template_reqmod_icap, String
property :acl_name_list, Array
property :stats_data_action, ['stats-data-enable','stats-data-disable']
property :template_connection_reuse, String
property :uuid, String
property :template_tcp, String
property :template_persist_cookie, String
property :when_down, [true, false]
property :reset, [true, false]
property :auto, [true, false]
property :use_rcv_hop_for_resp, [true, false]
property :scaleout_bucket_count, Integer
property :req_fail, [true, false]
property :no_dest_nat, [true, false]
property :template_policy, String
property :user_tag, String
property :template_diameter, String
property :sampling_enable, Array
property :template_ssli, String
property :template_smpp, String
property :no_logging, [true, false]
property :reset_on_server_selection_fail, [true, false]
property :waf_template, String
property :ipinip, [true, false]
property :no_auto_up_on_aflex, [true, false]
property :rate, Integer
property :gslb_enable, [true, false]
property :template_persist_ssl_sid, String
property :template_dns, String
property :template_sip, String
property :template_dblb, String
property :template_client_ssl, String
property :enable_playerid_check, [true, false]
property :service_group, String
property :def_selection_if_pref_failed, ['def-selection-if-pref-failed','def-selection-if-pref-failed-disable']
property :syn_cookie, [true, false]
property :alternate_port, [true, false]
property :template_cache, String
property :rtp_sip_call_id_match, [true, false]
property :template_file_inspection, String
property :template_ftp, String
property :serv_sel_fail, [true, false]
property :range, Integer
property :template_tcp_proxy_client, String
property :template_http, String
property :view, Integer
property :template_persist_source_ip, String
property :template_dynamic_service, String
property :use_cgnv6, [true, false]
property :template_persist_destination_ip, String
property :template_virtual_port, String
property :conn_limit, Integer
property :trunk_fwd, String
property :force_routing_mode, [true, false]
property :pool, String
property :snat_on_vip, [true, false]
property :template_tcp_proxy_server, String
property :template_external_service, String
property :template_udp, String
property :template_scaleout, String
property :when_down_protocol2, [true, false]
property :template_fix, String
property :template_smtp, String
property :redirect_to_https, [true, false]
property :alt_protocol2, ['tcp']
property :alt_protocol1, ['http']
property :message_switching, [true, false]
property :template_imap_pop3, String
property :scaleout_device_group, Integer
property :l7_hardware_assist, [true, false]
property :template_http_policy, String
property :use_alternate_port, [true, false]
property :acl_id_list, Array
property :trunk_rev, String
property :eth_fwd, String
property :template_respmod_icap, String
property :use_default_if_no_server, [true, false]
property :persist_type, ['src-dst-ip-swap-persist','use-src-ip-for-dst-persist','use-dst-ip-for-src-persist']
property :aflex_scripts, Array
property :template_server_ssl, String
property :alternate_port_number, Integer
property :port_number, Integer,required: true
property :a10_action, ['enable','disable']
property :template_tcp_proxy, String
property :extended_stats, [true, false]
property :expand, [true, false]
property :skip_rev_hash, [true, false]
property :on_syn, [true, false]
property :clientip_sticky_nat, [true, false]
property :secs, Integer
property :auth_cfg, Hash
property :eth_rev, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/virtual-server/%<name>s/port/"
    get_url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s"
    ha_conn_mirror = new_resource.ha_conn_mirror
    protocol = new_resource.protocol
    precedence = new_resource.precedence
    port_translation = new_resource.port_translation
    template_reqmod_icap = new_resource.template_reqmod_icap
    acl_name_list = new_resource.acl_name_list
    stats_data_action = new_resource.stats_data_action
    template_connection_reuse = new_resource.template_connection_reuse
    uuid = new_resource.uuid
    template_tcp = new_resource.template_tcp
    template_persist_cookie = new_resource.template_persist_cookie
    when_down = new_resource.when_down
    reset = new_resource.reset
    auto = new_resource.auto
    use_rcv_hop_for_resp = new_resource.use_rcv_hop_for_resp
    scaleout_bucket_count = new_resource.scaleout_bucket_count
    req_fail = new_resource.req_fail
    no_dest_nat = new_resource.no_dest_nat
    a10_name = new_resource.a10_name
    template_policy = new_resource.template_policy
    user_tag = new_resource.user_tag
    template_diameter = new_resource.template_diameter
    sampling_enable = new_resource.sampling_enable
    template_ssli = new_resource.template_ssli
    template_smpp = new_resource.template_smpp
    no_logging = new_resource.no_logging
    reset_on_server_selection_fail = new_resource.reset_on_server_selection_fail
    waf_template = new_resource.waf_template
    ipinip = new_resource.ipinip
    no_auto_up_on_aflex = new_resource.no_auto_up_on_aflex
    rate = new_resource.rate
    gslb_enable = new_resource.gslb_enable
    template_persist_ssl_sid = new_resource.template_persist_ssl_sid
    template_dns = new_resource.template_dns
    template_sip = new_resource.template_sip
    template_dblb = new_resource.template_dblb
    template_client_ssl = new_resource.template_client_ssl
    enable_playerid_check = new_resource.enable_playerid_check
    service_group = new_resource.service_group
    def_selection_if_pref_failed = new_resource.def_selection_if_pref_failed
    syn_cookie = new_resource.syn_cookie
    alternate_port = new_resource.alternate_port
    template_cache = new_resource.template_cache
    rtp_sip_call_id_match = new_resource.rtp_sip_call_id_match
    template_file_inspection = new_resource.template_file_inspection
    template_ftp = new_resource.template_ftp
    serv_sel_fail = new_resource.serv_sel_fail
    range = new_resource.range
    template_tcp_proxy_client = new_resource.template_tcp_proxy_client
    template_http = new_resource.template_http
    view = new_resource.view
    template_persist_source_ip = new_resource.template_persist_source_ip
    template_dynamic_service = new_resource.template_dynamic_service
    use_cgnv6 = new_resource.use_cgnv6
    template_persist_destination_ip = new_resource.template_persist_destination_ip
    template_virtual_port = new_resource.template_virtual_port
    conn_limit = new_resource.conn_limit
    trunk_fwd = new_resource.trunk_fwd
    force_routing_mode = new_resource.force_routing_mode
    pool = new_resource.pool
    snat_on_vip = new_resource.snat_on_vip
    template_tcp_proxy_server = new_resource.template_tcp_proxy_server
    template_external_service = new_resource.template_external_service
    template_udp = new_resource.template_udp
    template_scaleout = new_resource.template_scaleout
    when_down_protocol2 = new_resource.when_down_protocol2
    template_fix = new_resource.template_fix
    template_smtp = new_resource.template_smtp
    redirect_to_https = new_resource.redirect_to_https
    alt_protocol2 = new_resource.alt_protocol2
    alt_protocol1 = new_resource.alt_protocol1
    message_switching = new_resource.message_switching
    template_imap_pop3 = new_resource.template_imap_pop3
    scaleout_device_group = new_resource.scaleout_device_group
    l7_hardware_assist = new_resource.l7_hardware_assist
    template_http_policy = new_resource.template_http_policy
    use_alternate_port = new_resource.use_alternate_port
    acl_id_list = new_resource.acl_id_list
    trunk_rev = new_resource.trunk_rev
    eth_fwd = new_resource.eth_fwd
    template_respmod_icap = new_resource.template_respmod_icap
    use_default_if_no_server = new_resource.use_default_if_no_server
    persist_type = new_resource.persist_type
    aflex_scripts = new_resource.aflex_scripts
    template_server_ssl = new_resource.template_server_ssl
    alternate_port_number = new_resource.alternate_port_number
    port_number = new_resource.port_number
    a10_name = new_resource.a10_name
    template_tcp_proxy = new_resource.template_tcp_proxy
    extended_stats = new_resource.extended_stats
    expand = new_resource.expand
    skip_rev_hash = new_resource.skip_rev_hash
    on_syn = new_resource.on_syn
    clientip_sticky_nat = new_resource.clientip_sticky_nat
    secs = new_resource.secs
    auth_cfg = new_resource.auth_cfg
    eth_rev = new_resource.eth_rev

    params = { "port": {"ha-conn-mirror": ha_conn_mirror,
        "protocol": protocol,
        "precedence": precedence,
        "port-translation": port_translation,
        "template-reqmod-icap": template_reqmod_icap,
        "acl-name-list": acl_name_list,
        "stats-data-action": stats_data_action,
        "template-connection-reuse": template_connection_reuse,
        "uuid": uuid,
        "template-tcp": template_tcp,
        "template-persist-cookie": template_persist_cookie,
        "when-down": when_down,
        "reset": reset,
        "auto": auto,
        "use-rcv-hop-for-resp": use_rcv_hop_for_resp,
        "scaleout-bucket-count": scaleout_bucket_count,
        "req-fail": req_fail,
        "no-dest-nat": no_dest_nat,
        "name": a10_name,
        "template-policy": template_policy,
        "user-tag": user_tag,
        "template-diameter": template_diameter,
        "sampling-enable": sampling_enable,
        "template-ssli": template_ssli,
        "template-smpp": template_smpp,
        "no-logging": no_logging,
        "reset-on-server-selection-fail": reset_on_server_selection_fail,
        "waf-template": waf_template,
        "ipinip": ipinip,
        "no-auto-up-on-aflex": no_auto_up_on_aflex,
        "rate": rate,
        "gslb-enable": gslb_enable,
        "template-persist-ssl-sid": template_persist_ssl_sid,
        "template-dns": template_dns,
        "template-sip": template_sip,
        "template-dblb": template_dblb,
        "template-client-ssl": template_client_ssl,
        "enable-playerid-check": enable_playerid_check,
        "service-group": service_group,
        "def-selection-if-pref-failed": def_selection_if_pref_failed,
        "syn-cookie": syn_cookie,
        "alternate-port": alternate_port,
        "template-cache": template_cache,
        "rtp-sip-call-id-match": rtp_sip_call_id_match,
        "template-file-inspection": template_file_inspection,
        "template-ftp": template_ftp,
        "serv-sel-fail": serv_sel_fail,
        "range": range,
        "template-tcp-proxy-client": template_tcp_proxy_client,
        "template-http": template_http,
        "view": view,
        "template-persist-source-ip": template_persist_source_ip,
        "template-dynamic-service": template_dynamic_service,
        "use-cgnv6": use_cgnv6,
        "template-persist-destination-ip": template_persist_destination_ip,
        "template-virtual-port": template_virtual_port,
        "conn-limit": conn_limit,
        "trunk-fwd": trunk_fwd,
        "force-routing-mode": force_routing_mode,
        "pool": pool,
        "snat-on-vip": snat_on_vip,
        "template-tcp-proxy-server": template_tcp_proxy_server,
        "template-external-service": template_external_service,
        "template-udp": template_udp,
        "template-scaleout": template_scaleout,
        "when-down-protocol2": when_down_protocol2,
        "template-fix": template_fix,
        "template-smtp": template_smtp,
        "redirect-to-https": redirect_to_https,
        "alt-protocol2": alt_protocol2,
        "alt-protocol1": alt_protocol1,
        "message-switching": message_switching,
        "template-imap-pop3": template_imap_pop3,
        "scaleout-device-group": scaleout_device_group,
        "l7-hardware-assist": l7_hardware_assist,
        "template-http-policy": template_http_policy,
        "use-alternate-port": use_alternate_port,
        "acl-id-list": acl_id_list,
        "trunk-rev": trunk_rev,
        "eth-fwd": eth_fwd,
        "template-respmod-icap": template_respmod_icap,
        "use-default-if-no-server": use_default_if_no_server,
        "persist-type": persist_type,
        "aflex-scripts": aflex_scripts,
        "template-server-ssl": template_server_ssl,
        "alternate-port-number": alternate_port_number,
        "port-number": port_number,
        "action": a10_action,
        "template-tcp-proxy": template_tcp_proxy,
        "extended-stats": extended_stats,
        "expand": expand,
        "skip-rev-hash": skip_rev_hash,
        "on-syn": on_syn,
        "clientip-sticky-nat": clientip_sticky_nat,
        "secs": secs,
        "auth-cfg": auth_cfg,
        "eth-rev": eth_rev,} }

    params[:"port"].each do |k, v|
        if not v 
            params[:"port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s"
    ha_conn_mirror = new_resource.ha_conn_mirror
    protocol = new_resource.protocol
    precedence = new_resource.precedence
    port_translation = new_resource.port_translation
    template_reqmod_icap = new_resource.template_reqmod_icap
    acl_name_list = new_resource.acl_name_list
    stats_data_action = new_resource.stats_data_action
    template_connection_reuse = new_resource.template_connection_reuse
    uuid = new_resource.uuid
    template_tcp = new_resource.template_tcp
    template_persist_cookie = new_resource.template_persist_cookie
    when_down = new_resource.when_down
    reset = new_resource.reset
    auto = new_resource.auto
    use_rcv_hop_for_resp = new_resource.use_rcv_hop_for_resp
    scaleout_bucket_count = new_resource.scaleout_bucket_count
    req_fail = new_resource.req_fail
    no_dest_nat = new_resource.no_dest_nat
    a10_name = new_resource.a10_name
    template_policy = new_resource.template_policy
    user_tag = new_resource.user_tag
    template_diameter = new_resource.template_diameter
    sampling_enable = new_resource.sampling_enable
    template_ssli = new_resource.template_ssli
    template_smpp = new_resource.template_smpp
    no_logging = new_resource.no_logging
    reset_on_server_selection_fail = new_resource.reset_on_server_selection_fail
    waf_template = new_resource.waf_template
    ipinip = new_resource.ipinip
    no_auto_up_on_aflex = new_resource.no_auto_up_on_aflex
    rate = new_resource.rate
    gslb_enable = new_resource.gslb_enable
    template_persist_ssl_sid = new_resource.template_persist_ssl_sid
    template_dns = new_resource.template_dns
    template_sip = new_resource.template_sip
    template_dblb = new_resource.template_dblb
    template_client_ssl = new_resource.template_client_ssl
    enable_playerid_check = new_resource.enable_playerid_check
    service_group = new_resource.service_group
    def_selection_if_pref_failed = new_resource.def_selection_if_pref_failed
    syn_cookie = new_resource.syn_cookie
    alternate_port = new_resource.alternate_port
    template_cache = new_resource.template_cache
    rtp_sip_call_id_match = new_resource.rtp_sip_call_id_match
    template_file_inspection = new_resource.template_file_inspection
    template_ftp = new_resource.template_ftp
    serv_sel_fail = new_resource.serv_sel_fail
    range = new_resource.range
    template_tcp_proxy_client = new_resource.template_tcp_proxy_client
    template_http = new_resource.template_http
    view = new_resource.view
    template_persist_source_ip = new_resource.template_persist_source_ip
    template_dynamic_service = new_resource.template_dynamic_service
    use_cgnv6 = new_resource.use_cgnv6
    template_persist_destination_ip = new_resource.template_persist_destination_ip
    template_virtual_port = new_resource.template_virtual_port
    conn_limit = new_resource.conn_limit
    trunk_fwd = new_resource.trunk_fwd
    force_routing_mode = new_resource.force_routing_mode
    pool = new_resource.pool
    snat_on_vip = new_resource.snat_on_vip
    template_tcp_proxy_server = new_resource.template_tcp_proxy_server
    template_external_service = new_resource.template_external_service
    template_udp = new_resource.template_udp
    template_scaleout = new_resource.template_scaleout
    when_down_protocol2 = new_resource.when_down_protocol2
    template_fix = new_resource.template_fix
    template_smtp = new_resource.template_smtp
    redirect_to_https = new_resource.redirect_to_https
    alt_protocol2 = new_resource.alt_protocol2
    alt_protocol1 = new_resource.alt_protocol1
    message_switching = new_resource.message_switching
    template_imap_pop3 = new_resource.template_imap_pop3
    scaleout_device_group = new_resource.scaleout_device_group
    l7_hardware_assist = new_resource.l7_hardware_assist
    template_http_policy = new_resource.template_http_policy
    use_alternate_port = new_resource.use_alternate_port
    acl_id_list = new_resource.acl_id_list
    trunk_rev = new_resource.trunk_rev
    eth_fwd = new_resource.eth_fwd
    template_respmod_icap = new_resource.template_respmod_icap
    use_default_if_no_server = new_resource.use_default_if_no_server
    persist_type = new_resource.persist_type
    aflex_scripts = new_resource.aflex_scripts
    template_server_ssl = new_resource.template_server_ssl
    alternate_port_number = new_resource.alternate_port_number
    port_number = new_resource.port_number
    a10_name = new_resource.a10_name
    template_tcp_proxy = new_resource.template_tcp_proxy
    extended_stats = new_resource.extended_stats
    expand = new_resource.expand
    skip_rev_hash = new_resource.skip_rev_hash
    on_syn = new_resource.on_syn
    clientip_sticky_nat = new_resource.clientip_sticky_nat
    secs = new_resource.secs
    auth_cfg = new_resource.auth_cfg
    eth_rev = new_resource.eth_rev

    params = { "port": {"ha-conn-mirror": ha_conn_mirror,
        "protocol": protocol,
        "precedence": precedence,
        "port-translation": port_translation,
        "template-reqmod-icap": template_reqmod_icap,
        "acl-name-list": acl_name_list,
        "stats-data-action": stats_data_action,
        "template-connection-reuse": template_connection_reuse,
        "uuid": uuid,
        "template-tcp": template_tcp,
        "template-persist-cookie": template_persist_cookie,
        "when-down": when_down,
        "reset": reset,
        "auto": auto,
        "use-rcv-hop-for-resp": use_rcv_hop_for_resp,
        "scaleout-bucket-count": scaleout_bucket_count,
        "req-fail": req_fail,
        "no-dest-nat": no_dest_nat,
        "name": a10_name,
        "template-policy": template_policy,
        "user-tag": user_tag,
        "template-diameter": template_diameter,
        "sampling-enable": sampling_enable,
        "template-ssli": template_ssli,
        "template-smpp": template_smpp,
        "no-logging": no_logging,
        "reset-on-server-selection-fail": reset_on_server_selection_fail,
        "waf-template": waf_template,
        "ipinip": ipinip,
        "no-auto-up-on-aflex": no_auto_up_on_aflex,
        "rate": rate,
        "gslb-enable": gslb_enable,
        "template-persist-ssl-sid": template_persist_ssl_sid,
        "template-dns": template_dns,
        "template-sip": template_sip,
        "template-dblb": template_dblb,
        "template-client-ssl": template_client_ssl,
        "enable-playerid-check": enable_playerid_check,
        "service-group": service_group,
        "def-selection-if-pref-failed": def_selection_if_pref_failed,
        "syn-cookie": syn_cookie,
        "alternate-port": alternate_port,
        "template-cache": template_cache,
        "rtp-sip-call-id-match": rtp_sip_call_id_match,
        "template-file-inspection": template_file_inspection,
        "template-ftp": template_ftp,
        "serv-sel-fail": serv_sel_fail,
        "range": range,
        "template-tcp-proxy-client": template_tcp_proxy_client,
        "template-http": template_http,
        "view": view,
        "template-persist-source-ip": template_persist_source_ip,
        "template-dynamic-service": template_dynamic_service,
        "use-cgnv6": use_cgnv6,
        "template-persist-destination-ip": template_persist_destination_ip,
        "template-virtual-port": template_virtual_port,
        "conn-limit": conn_limit,
        "trunk-fwd": trunk_fwd,
        "force-routing-mode": force_routing_mode,
        "pool": pool,
        "snat-on-vip": snat_on_vip,
        "template-tcp-proxy-server": template_tcp_proxy_server,
        "template-external-service": template_external_service,
        "template-udp": template_udp,
        "template-scaleout": template_scaleout,
        "when-down-protocol2": when_down_protocol2,
        "template-fix": template_fix,
        "template-smtp": template_smtp,
        "redirect-to-https": redirect_to_https,
        "alt-protocol2": alt_protocol2,
        "alt-protocol1": alt_protocol1,
        "message-switching": message_switching,
        "template-imap-pop3": template_imap_pop3,
        "scaleout-device-group": scaleout_device_group,
        "l7-hardware-assist": l7_hardware_assist,
        "template-http-policy": template_http_policy,
        "use-alternate-port": use_alternate_port,
        "acl-id-list": acl_id_list,
        "trunk-rev": trunk_rev,
        "eth-fwd": eth_fwd,
        "template-respmod-icap": template_respmod_icap,
        "use-default-if-no-server": use_default_if_no_server,
        "persist-type": persist_type,
        "aflex-scripts": aflex_scripts,
        "template-server-ssl": template_server_ssl,
        "alternate-port-number": alternate_port_number,
        "port-number": port_number,
        "action": a10_action,
        "template-tcp-proxy": template_tcp_proxy,
        "extended-stats": extended_stats,
        "expand": expand,
        "skip-rev-hash": skip_rev_hash,
        "on-syn": on_syn,
        "clientip-sticky-nat": clientip_sticky_nat,
        "secs": secs,
        "auth-cfg": auth_cfg,
        "eth-rev": eth_rev,} }

    params[:"port"].each do |k, v|
        if not v
            params[:"port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port"].each do |k, v|
        if v != params[:"port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port') do
            client.delete(url)
        end
    end
end