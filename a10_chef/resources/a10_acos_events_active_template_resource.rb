resource_name :a10_acos_events_active_template

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/"
    get_url = "/axapi/v3/acos-events/active-template"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "active-template": {"name": a10_name,
        "uuid": uuid,} }

    params[:"active-template"].each do |k, v|
        if not v 
            params[:"active-template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating active-template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/active-template"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "active-template": {"name": a10_name,
        "uuid": uuid,} }

    params[:"active-template"].each do |k, v|
        if not v
            params[:"active-template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["active-template"].each do |k, v|
        if v != params[:"active-template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating active-template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/active-template"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting active-template') do
            client.delete(url)
        end
    end
end