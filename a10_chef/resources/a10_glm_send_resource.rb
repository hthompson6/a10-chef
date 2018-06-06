resource_name :a10_glm_send

property :a10_name, String, name_property: true
property :license_request, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/glm/"
    get_url = "/axapi/v3/glm/send"
    license_request = new_resource.license_request

    params = { "send": {"license-request": license_request,} }

    params[:"send"].each do |k, v|
        if not v 
            params[:"send"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating send') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glm/send"
    license_request = new_resource.license_request

    params = { "send": {"license-request": license_request,} }

    params[:"send"].each do |k, v|
        if not v
            params[:"send"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["send"].each do |k, v|
        if v != params[:"send"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating send') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/glm/send"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting send') do
            client.delete(url)
        end
    end
end