resource_name :a10_slb_player_id_global

property :a10_name, String, name_property: true
property :min_expiration, Integer
property :uuid, String
property :pkt_activity_expiration, Integer
property :force_passive, [true, false]
property :abs_max_expiration, Integer
property :sampling_enable, Array
property :enforcement_timer, Integer
property :enable_64bit_player_id, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/player-id-global"
    min_expiration = new_resource.min_expiration
    uuid = new_resource.uuid
    pkt_activity_expiration = new_resource.pkt_activity_expiration
    force_passive = new_resource.force_passive
    abs_max_expiration = new_resource.abs_max_expiration
    sampling_enable = new_resource.sampling_enable
    enforcement_timer = new_resource.enforcement_timer
    enable_64bit_player_id = new_resource.enable_64bit_player_id

    params = { "player-id-global": {"min-expiration": min_expiration,
        "uuid": uuid,
        "pkt-activity-expiration": pkt_activity_expiration,
        "force-passive": force_passive,
        "abs-max-expiration": abs_max_expiration,
        "sampling-enable": sampling_enable,
        "enforcement-timer": enforcement_timer,
        "enable-64bit-player-id": enable_64bit_player_id,} }

    params[:"player-id-global"].each do |k, v|
        if not v 
            params[:"player-id-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating player-id-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/player-id-global"
    min_expiration = new_resource.min_expiration
    uuid = new_resource.uuid
    pkt_activity_expiration = new_resource.pkt_activity_expiration
    force_passive = new_resource.force_passive
    abs_max_expiration = new_resource.abs_max_expiration
    sampling_enable = new_resource.sampling_enable
    enforcement_timer = new_resource.enforcement_timer
    enable_64bit_player_id = new_resource.enable_64bit_player_id

    params = { "player-id-global": {"min-expiration": min_expiration,
        "uuid": uuid,
        "pkt-activity-expiration": pkt_activity_expiration,
        "force-passive": force_passive,
        "abs-max-expiration": abs_max_expiration,
        "sampling-enable": sampling_enable,
        "enforcement-timer": enforcement_timer,
        "enable-64bit-player-id": enable_64bit_player_id,} }

    params[:"player-id-global"].each do |k, v|
        if not v
            params[:"player-id-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["player-id-global"].each do |k, v|
        if v != params[:"player-id-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating player-id-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/player-id-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting player-id-global') do
            client.delete(url)
        end
    end
end