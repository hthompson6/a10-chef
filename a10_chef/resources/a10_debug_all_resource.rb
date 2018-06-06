resource_name :a10_debug_all

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/all"
    uuid = new_resource.uuid

    params = { "all": {"uuid": uuid,} }

    params[:"all"].each do |k, v|
        if not v 
            params[:"all"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating all') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/all"
    uuid = new_resource.uuid

    params = { "all": {"uuid": uuid,} }

    params[:"all"].each do |k, v|
        if not v
            params[:"all"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["all"].each do |k, v|
        if v != params[:"all"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating all') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/all"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting all') do
            client.delete(url)
        end
    end
end