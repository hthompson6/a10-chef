resource_name :a10_automatic_update_revert

property :a10_name, String, name_property: true
property :feature_name, ['app-fw']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/automatic-update/"
    get_url = "/axapi/v3/automatic-update/revert"
    feature_name = new_resource.feature_name

    params = { "revert": {"feature-name": feature_name,} }

    params[:"revert"].each do |k, v|
        if not v 
            params[:"revert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating revert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/revert"
    feature_name = new_resource.feature_name

    params = { "revert": {"feature-name": feature_name,} }

    params[:"revert"].each do |k, v|
        if not v
            params[:"revert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["revert"].each do |k, v|
        if v != params[:"revert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating revert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update/revert"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting revert') do
            client.delete(url)
        end
    end
end