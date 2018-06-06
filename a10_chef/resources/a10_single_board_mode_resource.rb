resource_name :a10_single_board_mode

property :a10_name, String, name_property: true
property :forced, [true, false]
property :fallback, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/single-board-mode"
    forced = new_resource.forced
    fallback = new_resource.fallback
    uuid = new_resource.uuid

    params = { "single-board-mode": {"forced": forced,
        "fallback": fallback,
        "uuid": uuid,} }

    params[:"single-board-mode"].each do |k, v|
        if not v 
            params[:"single-board-mode"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating single-board-mode') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/single-board-mode"
    forced = new_resource.forced
    fallback = new_resource.fallback
    uuid = new_resource.uuid

    params = { "single-board-mode": {"forced": forced,
        "fallback": fallback,
        "uuid": uuid,} }

    params[:"single-board-mode"].each do |k, v|
        if not v
            params[:"single-board-mode"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["single-board-mode"].each do |k, v|
        if v != params[:"single-board-mode"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating single-board-mode') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/single-board-mode"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting single-board-mode') do
            client.delete(url)
        end
    end
end