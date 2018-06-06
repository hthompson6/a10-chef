resource_name :a10_aam_authentication_saml_identity_provider

property :a10_name, String, name_property: true
property :reload_metadata, [true, false]
property :user_tag, String
property :reload_interval, Integer
property :metadata, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/saml/identity-provider/"
    get_url = "/axapi/v3/aam/authentication/saml/identity-provider/%<name>s"
    reload_metadata = new_resource.reload_metadata
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    reload_interval = new_resource.reload_interval
    metadata = new_resource.metadata
    uuid = new_resource.uuid

    params = { "identity-provider": {"reload-metadata": reload_metadata,
        "name": a10_name,
        "user-tag": user_tag,
        "reload-interval": reload_interval,
        "metadata": metadata,
        "uuid": uuid,} }

    params[:"identity-provider"].each do |k, v|
        if not v 
            params[:"identity-provider"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating identity-provider') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/identity-provider/%<name>s"
    reload_metadata = new_resource.reload_metadata
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    reload_interval = new_resource.reload_interval
    metadata = new_resource.metadata
    uuid = new_resource.uuid

    params = { "identity-provider": {"reload-metadata": reload_metadata,
        "name": a10_name,
        "user-tag": user_tag,
        "reload-interval": reload_interval,
        "metadata": metadata,
        "uuid": uuid,} }

    params[:"identity-provider"].each do |k, v|
        if not v
            params[:"identity-provider"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["identity-provider"].each do |k, v|
        if v != params[:"identity-provider"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating identity-provider') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/identity-provider/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting identity-provider') do
            client.delete(url)
        end
    end
end