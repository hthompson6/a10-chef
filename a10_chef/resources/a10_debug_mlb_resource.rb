resource_name :a10_debug_mlb

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/mlb"
    uuid = new_resource.uuid

    params = { "mlb": {"uuid": uuid,} }

    params[:"mlb"].each do |k, v|
        if not v 
            params[:"mlb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mlb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/mlb"
    uuid = new_resource.uuid

    params = { "mlb": {"uuid": uuid,} }

    params[:"mlb"].each do |k, v|
        if not v
            params[:"mlb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mlb"].each do |k, v|
        if v != params[:"mlb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mlb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/mlb"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mlb') do
            client.delete(url)
        end
    end
end