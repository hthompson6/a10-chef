resource_name :a10_vrrp_a_common

property :a10_name, String, name_property: true
property :forward_l4_packet_on_standby, [true, false]
property :get_ready_time, Integer
property :hello_interval, Integer
property :uuid, String
property :preemption_delay, Integer
property :set_id, Integer
property :device_id, Integer
property :arp_retry, Integer
property :dead_timer, Integer
property :disable_default_vrid, [true, false]
property :track_event_delay, Integer
property :a10_action, ['enable','disable']
property :hostid_append_to_vrid, Hash
property :restart_time, Integer
property :inline_mode_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/"
    get_url = "/axapi/v3/vrrp-a/common"
    forward_l4_packet_on_standby = new_resource.forward_l4_packet_on_standby
    get_ready_time = new_resource.get_ready_time
    hello_interval = new_resource.hello_interval
    uuid = new_resource.uuid
    preemption_delay = new_resource.preemption_delay
    set_id = new_resource.set_id
    device_id = new_resource.device_id
    arp_retry = new_resource.arp_retry
    dead_timer = new_resource.dead_timer
    disable_default_vrid = new_resource.disable_default_vrid
    track_event_delay = new_resource.track_event_delay
    a10_name = new_resource.a10_name
    hostid_append_to_vrid = new_resource.hostid_append_to_vrid
    restart_time = new_resource.restart_time
    inline_mode_cfg = new_resource.inline_mode_cfg

    params = { "common": {"forward-l4-packet-on-standby": forward_l4_packet_on_standby,
        "get-ready-time": get_ready_time,
        "hello-interval": hello_interval,
        "uuid": uuid,
        "preemption-delay": preemption_delay,
        "set-id": set_id,
        "device-id": device_id,
        "arp-retry": arp_retry,
        "dead-timer": dead_timer,
        "disable-default-vrid": disable_default_vrid,
        "track-event-delay": track_event_delay,
        "action": a10_action,
        "hostid-append-to-vrid": hostid_append_to_vrid,
        "restart-time": restart_time,
        "inline-mode-cfg": inline_mode_cfg,} }

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
    url = "/axapi/v3/vrrp-a/common"
    forward_l4_packet_on_standby = new_resource.forward_l4_packet_on_standby
    get_ready_time = new_resource.get_ready_time
    hello_interval = new_resource.hello_interval
    uuid = new_resource.uuid
    preemption_delay = new_resource.preemption_delay
    set_id = new_resource.set_id
    device_id = new_resource.device_id
    arp_retry = new_resource.arp_retry
    dead_timer = new_resource.dead_timer
    disable_default_vrid = new_resource.disable_default_vrid
    track_event_delay = new_resource.track_event_delay
    a10_name = new_resource.a10_name
    hostid_append_to_vrid = new_resource.hostid_append_to_vrid
    restart_time = new_resource.restart_time
    inline_mode_cfg = new_resource.inline_mode_cfg

    params = { "common": {"forward-l4-packet-on-standby": forward_l4_packet_on_standby,
        "get-ready-time": get_ready_time,
        "hello-interval": hello_interval,
        "uuid": uuid,
        "preemption-delay": preemption_delay,
        "set-id": set_id,
        "device-id": device_id,
        "arp-retry": arp_retry,
        "dead-timer": dead_timer,
        "disable-default-vrid": disable_default_vrid,
        "track-event-delay": track_event_delay,
        "action": a10_action,
        "hostid-append-to-vrid": hostid_append_to_vrid,
        "restart-time": restart_time,
        "inline-mode-cfg": inline_mode_cfg,} }

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
    url = "/axapi/v3/vrrp-a/common"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting common') do
            client.delete(url)
        end
    end
end