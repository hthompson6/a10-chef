resource_name :a10_debug_vtep_error

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/vtep-error"
    uuid = new_resource.uuid

    params = { "vtep-error": {"uuid": uuid,} }

    params[:"vtep-error"].each do |k, v|
        if not v 
            params[:"vtep-error"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vtep-error') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/vtep-error"
    uuid = new_resource.uuid

    params = { "vtep-error": {"uuid": uuid,} }

    params[:"vtep-error"].each do |k, v|
        if not v
            params[:"vtep-error"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vtep-error"].each do |k, v|
        if v != params[:"vtep-error"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vtep-error') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/vtep-error"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vtep-error') do
            client.delete(url)
        end
    end
end