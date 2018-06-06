resource_name :a10_admin_password

property :a10_name, String, name_property: true
property :password_in_module, String
property :uuid, String
property :encrypted_in_module, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/admin/%<user>s/"
    get_url = "/axapi/v3/admin/%<user>s/password"
    password_in_module = new_resource.password_in_module
    uuid = new_resource.uuid
    encrypted_in_module = new_resource.encrypted_in_module

    params = { "password": {"password-in-module": password_in_module,
        "uuid": uuid,
        "encrypted-in-module": encrypted_in_module,} }

    params[:"password"].each do |k, v|
        if not v 
            params[:"password"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating password') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/password"
    password_in_module = new_resource.password_in_module
    uuid = new_resource.uuid
    encrypted_in_module = new_resource.encrypted_in_module

    params = { "password": {"password-in-module": password_in_module,
        "uuid": uuid,
        "encrypted-in-module": encrypted_in_module,} }

    params[:"password"].each do |k, v|
        if not v
            params[:"password"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["password"].each do |k, v|
        if v != params[:"password"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating password') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/admin/%<user>s/password"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting password') do
            client.delete(url)
        end
    end
end