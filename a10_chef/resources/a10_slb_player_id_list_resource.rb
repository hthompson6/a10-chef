resource_name :a10_slb_player_id_list

property :a10_name, String, name_property: true
property :player_record, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/player-id-list"
    player_record = new_resource.player_record

    params = { "player-id-list": {"player-record": player_record,} }

    params[:"player-id-list"].each do |k, v|
        if not v 
            params[:"player-id-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating player-id-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/player-id-list"
    player_record = new_resource.player_record

    params = { "player-id-list": {"player-record": player_record,} }

    params[:"player-id-list"].each do |k, v|
        if not v
            params[:"player-id-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["player-id-list"].each do |k, v|
        if v != params[:"player-id-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating player-id-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/player-id-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting player-id-list') do
            client.delete(url)
        end
    end
end