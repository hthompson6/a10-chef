resource_name :a10_debug_cli

property :a10_name, String, name_property: true
property :all, [true, false]
property :parser, [true, false]
property :uuid, String
property :io, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/cli"
    all = new_resource.all
    parser = new_resource.parser
    uuid = new_resource.uuid
    io = new_resource.io

    params = { "cli": {"all": all,
        "parser": parser,
        "uuid": uuid,
        "io": io,} }

    params[:"cli"].each do |k, v|
        if not v 
            params[:"cli"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cli') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/cli"
    all = new_resource.all
    parser = new_resource.parser
    uuid = new_resource.uuid
    io = new_resource.io

    params = { "cli": {"all": all,
        "parser": parser,
        "uuid": uuid,
        "io": io,} }

    params[:"cli"].each do |k, v|
        if not v
            params[:"cli"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cli"].each do |k, v|
        if v != params[:"cli"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cli') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/cli"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cli') do
            client.delete(url)
        end
    end
end