resource_name :a10_delete_auth_portal_image

property :a10_name, String, name_property: true
property :image_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/auth-portal-image"
    image_name = new_resource.image_name

    params = { "auth-portal-image": {"image-name": image_name,} }

    params[:"auth-portal-image"].each do |k, v|
        if not v 
            params[:"auth-portal-image"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auth-portal-image') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/auth-portal-image"
    image_name = new_resource.image_name

    params = { "auth-portal-image": {"image-name": image_name,} }

    params[:"auth-portal-image"].each do |k, v|
        if not v
            params[:"auth-portal-image"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auth-portal-image"].each do |k, v|
        if v != params[:"auth-portal-image"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auth-portal-image') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/auth-portal-image"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth-portal-image') do
            client.delete(url)
        end
    end
end