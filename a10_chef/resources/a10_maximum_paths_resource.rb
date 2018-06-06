resource_name :a10_maximum_paths

property :a10_name, String, name_property: true
property :path, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/maximum-paths"
    path = new_resource.path
    uuid = new_resource.uuid

    params = { "maximum-paths": {"path": path,
        "uuid": uuid,} }

    params[:"maximum-paths"].each do |k, v|
        if not v 
            params[:"maximum-paths"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating maximum-paths') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/maximum-paths"
    path = new_resource.path
    uuid = new_resource.uuid

    params = { "maximum-paths": {"path": path,
        "uuid": uuid,} }

    params[:"maximum-paths"].each do |k, v|
        if not v
            params[:"maximum-paths"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["maximum-paths"].each do |k, v|
        if v != params[:"maximum-paths"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating maximum-paths') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/maximum-paths"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting maximum-paths') do
            client.delete(url)
        end
    end
end