resource_name :a10_access_list_standard

property :a10_name, String, name_property: true
property :std, Integer,required: true
property :stdrules, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/access-list/standard/"
    get_url = "/axapi/v3/access-list/standard/%<std>s"
    std = new_resource.std
    stdrules = new_resource.stdrules
    uuid = new_resource.uuid

    params = { "standard": {"std": std,
        "stdrules": stdrules,
        "uuid": uuid,} }

    params[:"standard"].each do |k, v|
        if not v 
            params[:"standard"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating standard') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/access-list/standard/%<std>s"
    std = new_resource.std
    stdrules = new_resource.stdrules
    uuid = new_resource.uuid

    params = { "standard": {"std": std,
        "stdrules": stdrules,
        "uuid": uuid,} }

    params[:"standard"].each do |k, v|
        if not v
            params[:"standard"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["standard"].each do |k, v|
        if v != params[:"standard"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating standard') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/access-list/standard/%<std>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting standard') do
            client.delete(url)
        end
    end
end