resource_name :a10_delete_auth_saml_idp

property :a10_name, String, name_property: true
property :saml_idp_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/delete/"
    get_url = "/axapi/v3/delete/auth-saml-idp"
    saml_idp_name = new_resource.saml_idp_name

    params = { "auth-saml-idp": {"saml-idp-name": saml_idp_name,} }

    params[:"auth-saml-idp"].each do |k, v|
        if not v 
            params[:"auth-saml-idp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auth-saml-idp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/auth-saml-idp"
    saml_idp_name = new_resource.saml_idp_name

    params = { "auth-saml-idp": {"saml-idp-name": saml_idp_name,} }

    params[:"auth-saml-idp"].each do |k, v|
        if not v
            params[:"auth-saml-idp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auth-saml-idp"].each do |k, v|
        if v != params[:"auth-saml-idp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auth-saml-idp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/delete/auth-saml-idp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth-saml-idp') do
            client.delete(url)
        end
    end
end