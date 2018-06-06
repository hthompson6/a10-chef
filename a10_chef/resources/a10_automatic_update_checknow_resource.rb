resource_name :a10_automatic_update_checknow

property :a10_name, String, name_property: true
property :sampling_enable, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/automatic-update/"
    get_url = "/axapi/v3/automatic-update/checknow"
    sampling_enable = new_resource.sampling_enable

    params = { "checknow": {"sampling-enable": sampling_enable,} }

    params[:"checknow"].each do |k, v|
        if not v 
            params[:"checknow"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating checknow') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/checknow"
    sampling_enable = new_resource.sampling_enable

    params = { "checknow": {"sampling-enable": sampling_enable,} }

    params[:"checknow"].each do |k, v|
        if not v
            params[:"checknow"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["checknow"].each do |k, v|
        if v != params[:"checknow"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating checknow') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/checknow"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting checknow') do
            client.delete(url)
        end
    end
end