resource_name :a10_cmcov

property :a10_name, String, name_property: true
property :export, [true, false]
property :dump, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/cmcov"
    export = new_resource.export
    dump = new_resource.dump

    params = { "cmcov": {"export": export,
        "dump": dump,} }

    params[:"cmcov"].each do |k, v|
        if not v 
            params[:"cmcov"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cmcov') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cmcov"
    export = new_resource.export
    dump = new_resource.dump

    params = { "cmcov": {"export": export,
        "dump": dump,} }

    params[:"cmcov"].each do |k, v|
        if not v
            params[:"cmcov"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cmcov"].each do |k, v|
        if v != params[:"cmcov"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cmcov') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cmcov"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cmcov') do
            client.delete(url)
        end
    end
end