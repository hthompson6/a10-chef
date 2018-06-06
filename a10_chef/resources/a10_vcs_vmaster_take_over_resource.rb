resource_name :a10_vcs_vmaster_take_over

property :a10_name, String, name_property: true
property :vmaster_take_over, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/"
    get_url = "/axapi/v3/vcs/vmaster-take-over"
    vmaster_take_over = new_resource.vmaster_take_over

    params = { "vmaster-take-over": {"vmaster-take-over": vmaster_take_over,} }

    params[:"vmaster-take-over"].each do |k, v|
        if not v 
            params[:"vmaster-take-over"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vmaster-take-over') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vmaster-take-over"
    vmaster_take_over = new_resource.vmaster_take_over

    params = { "vmaster-take-over": {"vmaster-take-over": vmaster_take_over,} }

    params[:"vmaster-take-over"].each do |k, v|
        if not v
            params[:"vmaster-take-over"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vmaster-take-over"].each do |k, v|
        if v != params[:"vmaster-take-over"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vmaster-take-over') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vmaster-take-over"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vmaster-take-over') do
            client.delete(url)
        end
    end
end