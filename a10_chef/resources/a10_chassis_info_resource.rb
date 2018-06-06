resource_name :a10_chassis_info

property :a10_name, String, name_property: true
property :brief, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/chassis-info"
    brief = new_resource.brief

    params = { "chassis-info": {"brief": brief,} }

    params[:"chassis-info"].each do |k, v|
        if not v 
            params[:"chassis-info"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating chassis-info') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/chassis-info"
    brief = new_resource.brief

    params = { "chassis-info": {"brief": brief,} }

    params[:"chassis-info"].each do |k, v|
        if not v
            params[:"chassis-info"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["chassis-info"].each do |k, v|
        if v != params[:"chassis-info"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating chassis-info') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/chassis-info"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting chassis-info') do
            client.delete(url)
        end
    end
end