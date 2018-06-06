resource_name :a10_slb_template_tcp_proxy

property :a10_name, String, name_property: true
property :qos, Integer
property :init_cwnd, Integer
property :idle_timeout, Integer
property :fin_timeout, Integer
property :half_open_idle_timeout, Integer
property :reno, [true, false]
property :down, [true, false]
property :server_down_action, ['FIN','RST']
property :timewait, Integer
property :dynamic_buffer_allocation, [true, false]
property :uuid, String
property :disable_sack, [true, false]
property :alive_if_active, [true, false]
property :mss, Integer
property :keepalive_interval, Integer
property :retransmit_retries, Integer
property :insert_client_ip, [true, false]
property :transmit_buffer, Integer
property :nagle, [true, false]
property :force_delete_timeout_100ms, Integer
property :initial_window_size, Integer
property :keepalive_probes, Integer
property :ack_aggressiveness, ['low','medium','high']
property :backend_wscale, Integer
property :disable, [true, false]
property :reset_rev, [true, false]
property :disable_window_scale, [true, false]
property :receive_buffer, Integer
property :del_session_on_server_down, [true, false]
property :reset_fwd, [true, false]
property :disable_tcp_timestamps, [true, false]
property :syn_retries, Integer
property :force_delete_timeout, Integer
property :user_tag, String
property :invalid_rate_limit, Integer
property :half_close_idle_timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/tcp-proxy/"
    get_url = "/axapi/v3/slb/template/tcp-proxy/%<name>s"
    qos = new_resource.qos
    init_cwnd = new_resource.init_cwnd
    idle_timeout = new_resource.idle_timeout
    fin_timeout = new_resource.fin_timeout
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    reno = new_resource.reno
    down = new_resource.down
    server_down_action = new_resource.server_down_action
    timewait = new_resource.timewait
    dynamic_buffer_allocation = new_resource.dynamic_buffer_allocation
    uuid = new_resource.uuid
    disable_sack = new_resource.disable_sack
    alive_if_active = new_resource.alive_if_active
    mss = new_resource.mss
    keepalive_interval = new_resource.keepalive_interval
    retransmit_retries = new_resource.retransmit_retries
    insert_client_ip = new_resource.insert_client_ip
    transmit_buffer = new_resource.transmit_buffer
    nagle = new_resource.nagle
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    initial_window_size = new_resource.initial_window_size
    keepalive_probes = new_resource.keepalive_probes
    ack_aggressiveness = new_resource.ack_aggressiveness
    backend_wscale = new_resource.backend_wscale
    disable = new_resource.disable
    reset_rev = new_resource.reset_rev
    disable_window_scale = new_resource.disable_window_scale
    receive_buffer = new_resource.receive_buffer
    del_session_on_server_down = new_resource.del_session_on_server_down
    a10_name = new_resource.a10_name
    reset_fwd = new_resource.reset_fwd
    disable_tcp_timestamps = new_resource.disable_tcp_timestamps
    syn_retries = new_resource.syn_retries
    force_delete_timeout = new_resource.force_delete_timeout
    user_tag = new_resource.user_tag
    invalid_rate_limit = new_resource.invalid_rate_limit
    half_close_idle_timeout = new_resource.half_close_idle_timeout

    params = { "tcp-proxy": {"qos": qos,
        "init-cwnd": init_cwnd,
        "idle-timeout": idle_timeout,
        "fin-timeout": fin_timeout,
        "half-open-idle-timeout": half_open_idle_timeout,
        "reno": reno,
        "down": down,
        "server-down-action": server_down_action,
        "timewait": timewait,
        "dynamic-buffer-allocation": dynamic_buffer_allocation,
        "uuid": uuid,
        "disable-sack": disable_sack,
        "alive-if-active": alive_if_active,
        "mss": mss,
        "keepalive-interval": keepalive_interval,
        "retransmit-retries": retransmit_retries,
        "insert-client-ip": insert_client_ip,
        "transmit-buffer": transmit_buffer,
        "nagle": nagle,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "initial-window-size": initial_window_size,
        "keepalive-probes": keepalive_probes,
        "ack-aggressiveness": ack_aggressiveness,
        "backend-wscale": backend_wscale,
        "disable": disable,
        "reset-rev": reset_rev,
        "disable-window-scale": disable_window_scale,
        "receive-buffer": receive_buffer,
        "del-session-on-server-down": del_session_on_server_down,
        "name": a10_name,
        "reset-fwd": reset_fwd,
        "disable-tcp-timestamps": disable_tcp_timestamps,
        "syn-retries": syn_retries,
        "force-delete-timeout": force_delete_timeout,
        "user-tag": user_tag,
        "invalid-rate-limit": invalid_rate_limit,
        "half-close-idle-timeout": half_close_idle_timeout,} }

    params[:"tcp-proxy"].each do |k, v|
        if not v 
            params[:"tcp-proxy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp-proxy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/tcp-proxy/%<name>s"
    qos = new_resource.qos
    init_cwnd = new_resource.init_cwnd
    idle_timeout = new_resource.idle_timeout
    fin_timeout = new_resource.fin_timeout
    half_open_idle_timeout = new_resource.half_open_idle_timeout
    reno = new_resource.reno
    down = new_resource.down
    server_down_action = new_resource.server_down_action
    timewait = new_resource.timewait
    dynamic_buffer_allocation = new_resource.dynamic_buffer_allocation
    uuid = new_resource.uuid
    disable_sack = new_resource.disable_sack
    alive_if_active = new_resource.alive_if_active
    mss = new_resource.mss
    keepalive_interval = new_resource.keepalive_interval
    retransmit_retries = new_resource.retransmit_retries
    insert_client_ip = new_resource.insert_client_ip
    transmit_buffer = new_resource.transmit_buffer
    nagle = new_resource.nagle
    force_delete_timeout_100ms = new_resource.force_delete_timeout_100ms
    initial_window_size = new_resource.initial_window_size
    keepalive_probes = new_resource.keepalive_probes
    ack_aggressiveness = new_resource.ack_aggressiveness
    backend_wscale = new_resource.backend_wscale
    disable = new_resource.disable
    reset_rev = new_resource.reset_rev
    disable_window_scale = new_resource.disable_window_scale
    receive_buffer = new_resource.receive_buffer
    del_session_on_server_down = new_resource.del_session_on_server_down
    a10_name = new_resource.a10_name
    reset_fwd = new_resource.reset_fwd
    disable_tcp_timestamps = new_resource.disable_tcp_timestamps
    syn_retries = new_resource.syn_retries
    force_delete_timeout = new_resource.force_delete_timeout
    user_tag = new_resource.user_tag
    invalid_rate_limit = new_resource.invalid_rate_limit
    half_close_idle_timeout = new_resource.half_close_idle_timeout

    params = { "tcp-proxy": {"qos": qos,
        "init-cwnd": init_cwnd,
        "idle-timeout": idle_timeout,
        "fin-timeout": fin_timeout,
        "half-open-idle-timeout": half_open_idle_timeout,
        "reno": reno,
        "down": down,
        "server-down-action": server_down_action,
        "timewait": timewait,
        "dynamic-buffer-allocation": dynamic_buffer_allocation,
        "uuid": uuid,
        "disable-sack": disable_sack,
        "alive-if-active": alive_if_active,
        "mss": mss,
        "keepalive-interval": keepalive_interval,
        "retransmit-retries": retransmit_retries,
        "insert-client-ip": insert_client_ip,
        "transmit-buffer": transmit_buffer,
        "nagle": nagle,
        "force-delete-timeout-100ms": force_delete_timeout_100ms,
        "initial-window-size": initial_window_size,
        "keepalive-probes": keepalive_probes,
        "ack-aggressiveness": ack_aggressiveness,
        "backend-wscale": backend_wscale,
        "disable": disable,
        "reset-rev": reset_rev,
        "disable-window-scale": disable_window_scale,
        "receive-buffer": receive_buffer,
        "del-session-on-server-down": del_session_on_server_down,
        "name": a10_name,
        "reset-fwd": reset_fwd,
        "disable-tcp-timestamps": disable_tcp_timestamps,
        "syn-retries": syn_retries,
        "force-delete-timeout": force_delete_timeout,
        "user-tag": user_tag,
        "invalid-rate-limit": invalid_rate_limit,
        "half-close-idle-timeout": half_close_idle_timeout,} }

    params[:"tcp-proxy"].each do |k, v|
        if not v
            params[:"tcp-proxy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp-proxy"].each do |k, v|
        if v != params[:"tcp-proxy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp-proxy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/tcp-proxy/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp-proxy') do
            client.delete(url)
        end
    end
end