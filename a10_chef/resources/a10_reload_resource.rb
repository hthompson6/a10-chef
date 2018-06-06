resource_name :a10_reload

property :a10_name, String, name_property: true
property :device, Integer
property :all, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/reload"
    device = new_resource.device
    all = new_resource.all

    params = { "reload": {"device": device,
        "all": all,} }

    params[:"reload"].each do |k, v|
        if not v 
            params[:"reload"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reload') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/reload"
    device = new_resource.device
    all = new_resource.all

    params = { "reload": {"device": device,
        "all": all,} }

    params[:"reload"].each do |k, v|
        if not v
            params[:"reload"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reload"].each do |k, v|
        if v != params[:"reload"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reload') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/reload"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reload') do
            client.delete(url)
        end
    end
end