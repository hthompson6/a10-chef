resource_name :a10_aam_authentication_relay_ws_federation

property :a10_name, String, name_property: true
property :authentication_uri, String
property :user_tag, String
property :sampling_enable, Array
property :application_server, ['sharepoint','exchange-owa']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/ws-federation/"
    get_url = "/axapi/v3/aam/authentication/relay/ws-federation/%<name>s"
    authentication_uri = new_resource.authentication_uri
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    application_server = new_resource.application_server
    uuid = new_resource.uuid

    params = { "ws-federation": {"authentication-uri": authentication_uri,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "application-server": application_server,
        "uuid": uuid,} }

    params[:"ws-federation"].each do |k, v|
        if not v 
            params[:"ws-federation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ws-federation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/ws-federation/%<name>s"
    authentication_uri = new_resource.authentication_uri
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    application_server = new_resource.application_server
    uuid = new_resource.uuid

    params = { "ws-federation": {"authentication-uri": authentication_uri,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "application-server": application_server,
        "uuid": uuid,} }

    params[:"ws-federation"].each do |k, v|
        if not v
            params[:"ws-federation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ws-federation"].each do |k, v|
        if v != params[:"ws-federation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ws-federation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/ws-federation/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ws-federation') do
            client.delete(url)
        end
    end
end