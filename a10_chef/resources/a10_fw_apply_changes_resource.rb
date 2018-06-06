resource_name :a10_fw_apply_changes

property :a10_name, String, name_property: true
property :forced, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/apply-changes"
    forced = new_resource.forced

    params = { "apply-changes": {"forced": forced,} }

    params[:"apply-changes"].each do |k, v|
        if not v 
            params[:"apply-changes"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating apply-changes') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/apply-changes"
    forced = new_resource.forced

    params = { "apply-changes": {"forced": forced,} }

    params[:"apply-changes"].each do |k, v|
        if not v
            params[:"apply-changes"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["apply-changes"].each do |k, v|
        if v != params[:"apply-changes"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating apply-changes') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/apply-changes"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting apply-changes') do
            client.delete(url)
        end
    end
end