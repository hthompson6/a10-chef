resource_name :a10_list_all_cli

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/list_all_cli"
    uuid = new_resource.uuid

    params = { "list_all_cli": {"uuid": uuid,} }

    params[:"list_all_cli"].each do |k, v|
        if not v 
            params[:"list_all_cli"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating list_all_cli') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/list_all_cli"
    uuid = new_resource.uuid

    params = { "list_all_cli": {"uuid": uuid,} }

    params[:"list_all_cli"].each do |k, v|
        if not v
            params[:"list_all_cli"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["list_all_cli"].each do |k, v|
        if v != params[:"list_all_cli"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating list_all_cli') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/list_all_cli"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting list_all_cli') do
            client.delete(url)
        end
    end
end