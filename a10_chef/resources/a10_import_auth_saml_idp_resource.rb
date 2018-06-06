resource_name :a10_import_auth_saml_idp

property :a10_name, String, name_property: true
property :remote_file, String
property :saml_idp_name, String
property :verify_xml_signature, [true, false]
property :password, String
property :use_mgmt_port, [true, false]
property :overwrite, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import/"
    get_url = "/axapi/v3/import/auth-saml-idp"
    remote_file = new_resource.remote_file
    saml_idp_name = new_resource.saml_idp_name
    verify_xml_signature = new_resource.verify_xml_signature
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "auth-saml-idp": {"remote-file": remote_file,
        "saml-idp-name": saml_idp_name,
        "verify-xml-signature": verify_xml_signature,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

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
    url = "/axapi/v3/import/auth-saml-idp"
    remote_file = new_resource.remote_file
    saml_idp_name = new_resource.saml_idp_name
    verify_xml_signature = new_resource.verify_xml_signature
    password = new_resource.password
    use_mgmt_port = new_resource.use_mgmt_port
    overwrite = new_resource.overwrite

    params = { "auth-saml-idp": {"remote-file": remote_file,
        "saml-idp-name": saml_idp_name,
        "verify-xml-signature": verify_xml_signature,
        "password": password,
        "use-mgmt-port": use_mgmt_port,
        "overwrite": overwrite,} }

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
    url = "/axapi/v3/import/auth-saml-idp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth-saml-idp') do
            client.delete(url)
        end
    end
end