resource_name :a10_vcs_action

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/"
    get_url = "/axapi/v3/vcs/action"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "action": {"action": a10_action,
        "uuid": uuid,} }

    params[:"action"].each do |k, v|
        if not v 
            params[:"action"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating action') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/action"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "action": {"action": a10_action,
        "uuid": uuid,} }

    params[:"action"].each do |k, v|
        if not v
            params[:"action"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["action"].each do |k, v|
        if v != params[:"action"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating action') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/action"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting action') do
            client.delete(url)
        end
    end
end