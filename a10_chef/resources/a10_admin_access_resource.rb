resource_name :a10_admin_access

property :a10_name, String, name_property: true
property :access_type, ['axapi','cli','web']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/admin/%<user>s/"
    get_url = "/axapi/v3/admin/%<user>s/access"
    access_type = new_resource.access_type
    uuid = new_resource.uuid

    params = { "access": {"access-type": access_type,
        "uuid": uuid,} }

    params[:"access"].each do |k, v|
        if not v 
            params[:"access"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating access') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/access"
    access_type = new_resource.access_type
    uuid = new_resource.uuid

    params = { "access": {"access-type": access_type,
        "uuid": uuid,} }

    params[:"access"].each do |k, v|
        if not v
            params[:"access"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["access"].each do |k, v|
        if v != params[:"access"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating access') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/access"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting access') do
            client.delete(url)
        end
    end
end