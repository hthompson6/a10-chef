resource_name :a10_vpn_ipsec

property :a10_name, String, name_property: true
property :uuid, String
property :lifebytes, Integer
property :bind_tunnel, Hash
property :dh_group, ['0','1','2','5','14','15','16','18','19','20']
property :proto, ['esp']
property :up, [true, false]
property :user_tag, String
property :anti_replay_window, ['0','32','64','128','256','512','1024']
property :sampling_enable, Array
property :ike_gateway, String
property :mode, ['tunnel']
property :sequence_number_disable, [true, false]
property :lifetime, Integer
property :enc_cfg, Array
property :traffic_selector, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vpn/ipsec/"
    get_url = "/axapi/v3/vpn/ipsec/%<name>s"
    uuid = new_resource.uuid
    lifebytes = new_resource.lifebytes
    bind_tunnel = new_resource.bind_tunnel
    a10_name = new_resource.a10_name
    dh_group = new_resource.dh_group
    proto = new_resource.proto
    up = new_resource.up
    user_tag = new_resource.user_tag
    anti_replay_window = new_resource.anti_replay_window
    sampling_enable = new_resource.sampling_enable
    ike_gateway = new_resource.ike_gateway
    mode = new_resource.mode
    sequence_number_disable = new_resource.sequence_number_disable
    lifetime = new_resource.lifetime
    enc_cfg = new_resource.enc_cfg
    traffic_selector = new_resource.traffic_selector

    params = { "ipsec": {"uuid": uuid,
        "lifebytes": lifebytes,
        "bind-tunnel": bind_tunnel,
        "name": a10_name,
        "dh-group": dh_group,
        "proto": proto,
        "up": up,
        "user-tag": user_tag,
        "anti-replay-window": anti_replay_window,
        "sampling-enable": sampling_enable,
        "ike-gateway": ike_gateway,
        "mode": mode,
        "sequence-number-disable": sequence_number_disable,
        "lifetime": lifetime,
        "enc-cfg": enc_cfg,
        "traffic-selector": traffic_selector,} }

    params[:"ipsec"].each do |k, v|
        if not v 
            params[:"ipsec"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipsec') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ipsec/%<name>s"
    uuid = new_resource.uuid
    lifebytes = new_resource.lifebytes
    bind_tunnel = new_resource.bind_tunnel
    a10_name = new_resource.a10_name
    dh_group = new_resource.dh_group
    proto = new_resource.proto
    up = new_resource.up
    user_tag = new_resource.user_tag
    anti_replay_window = new_resource.anti_replay_window
    sampling_enable = new_resource.sampling_enable
    ike_gateway = new_resource.ike_gateway
    mode = new_resource.mode
    sequence_number_disable = new_resource.sequence_number_disable
    lifetime = new_resource.lifetime
    enc_cfg = new_resource.enc_cfg
    traffic_selector = new_resource.traffic_selector

    params = { "ipsec": {"uuid": uuid,
        "lifebytes": lifebytes,
        "bind-tunnel": bind_tunnel,
        "name": a10_name,
        "dh-group": dh_group,
        "proto": proto,
        "up": up,
        "user-tag": user_tag,
        "anti-replay-window": anti_replay_window,
        "sampling-enable": sampling_enable,
        "ike-gateway": ike_gateway,
        "mode": mode,
        "sequence-number-disable": sequence_number_disable,
        "lifetime": lifetime,
        "enc-cfg": enc_cfg,
        "traffic-selector": traffic_selector,} }

    params[:"ipsec"].each do |k, v|
        if not v
            params[:"ipsec"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipsec"].each do |k, v|
        if v != params[:"ipsec"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipsec') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ipsec/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipsec') do
            client.delete(url)
        end
    end
end