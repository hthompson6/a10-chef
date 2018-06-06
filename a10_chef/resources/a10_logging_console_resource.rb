resource_name :a10_logging_console

property :a10_name, String, name_property: true
property :console_levelname, ['disable','emergency','alert','critical','error','warning','notification','information','debugging']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/console"
    console_levelname = new_resource.console_levelname
    uuid = new_resource.uuid

    params = { "console": {"console-levelname": console_levelname,
        "uuid": uuid,} }

    params[:"console"].each do |k, v|
        if not v 
            params[:"console"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating console') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/console"
    console_levelname = new_resource.console_levelname
    uuid = new_resource.uuid

    params = { "console": {"console-levelname": console_levelname,
        "uuid": uuid,} }

    params[:"console"].each do |k, v|
        if not v
            params[:"console"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["console"].each do |k, v|
        if v != params[:"console"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating console') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/console"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting console') do
            client.delete(url)
        end
    end
end