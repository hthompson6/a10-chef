resource_name :a10_debug_auth

property :a10_name, String, name_property: true
property :username, String
property :uuid, String
property :level, ['1','2']
property :saml_sp, String
property :saml, [true, false]
property :client_addr, String
property :virtual_server, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/auth"
    username = new_resource.username
    uuid = new_resource.uuid
    level = new_resource.level
    saml_sp = new_resource.saml_sp
    saml = new_resource.saml
    client_addr = new_resource.client_addr
    virtual_server = new_resource.virtual_server

    params = { "auth": {"username": username,
        "uuid": uuid,
        "level": level,
        "saml-sp": saml_sp,
        "saml": saml,
        "client-addr": client_addr,
        "virtual-server": virtual_server,} }

    params[:"auth"].each do |k, v|
        if not v 
            params[:"auth"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auth') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/auth"
    username = new_resource.username
    uuid = new_resource.uuid
    level = new_resource.level
    saml_sp = new_resource.saml_sp
    saml = new_resource.saml
    client_addr = new_resource.client_addr
    virtual_server = new_resource.virtual_server

    params = { "auth": {"username": username,
        "uuid": uuid,
        "level": level,
        "saml-sp": saml_sp,
        "saml": saml,
        "client-addr": client_addr,
        "virtual-server": virtual_server,} }

    params[:"auth"].each do |k, v|
        if not v
            params[:"auth"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auth"].each do |k, v|
        if v != params[:"auth"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auth') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/auth"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth') do
            client.delete(url)
        end
    end
end