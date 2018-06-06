resource_name :a10_import

property :a10_name, String, name_property: true
property :geo_location, String
property :ssl_cert_key, ['bulk']
property :class_list_convert, String
property :bw_list, String
property :usb_license, String
property :health_external, Hash
property :auth_portal, String
property :aflex, String
property :overwrite, [true, false]
property :class_list_type, ['ac','ipv4','ipv6','string','string-case-insensitive']
property :pfx_password, String
property :web_category_license, String
property :thales_kmdata, String
property :ssl_crl, String
property :terminal, [true, false]
property :policy, String
property :file_inspection_bw_list, [true, false]
property :thales_secworld, String
property :lw_4o6, String
property :auth_portal_image, String
property :health_postfile, Hash
property :class_list, String
property :glm_license, String
property :dnssec_ds, String
property :local_uri_file, String
property :wsdl, String
property :password, String
property :file_inspection_use_mgmt_port, [true, false]
property :ssl_key, String
property :use_mgmt_port, [true, false]
property :remote_file, String
property :to_device, Hash
property :user_tag, String
property :store_name, String
property :ca_cert, String
property :glm_cert, String
property :store, Hash
property :xml_schema, String
property :certificate_type, ['pem','der','pfx','p7b']
property :auth_saml_idp, Hash
property :ssl_cert, String
property :dnssec_dnskey, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/import"
    geo_location = new_resource.geo_location
    ssl_cert_key = new_resource.ssl_cert_key
    class_list_convert = new_resource.class_list_convert
    bw_list = new_resource.bw_list
    usb_license = new_resource.usb_license
    health_external = new_resource.health_external
    auth_portal = new_resource.auth_portal
    aflex = new_resource.aflex
    overwrite = new_resource.overwrite
    class_list_type = new_resource.class_list_type
    pfx_password = new_resource.pfx_password
    web_category_license = new_resource.web_category_license
    thales_kmdata = new_resource.thales_kmdata
    ssl_crl = new_resource.ssl_crl
    terminal = new_resource.terminal
    policy = new_resource.policy
    file_inspection_bw_list = new_resource.file_inspection_bw_list
    thales_secworld = new_resource.thales_secworld
    lw_4o6 = new_resource.lw_4o6
    auth_portal_image = new_resource.auth_portal_image
    health_postfile = new_resource.health_postfile
    class_list = new_resource.class_list
    glm_license = new_resource.glm_license
    dnssec_ds = new_resource.dnssec_ds
    local_uri_file = new_resource.local_uri_file
    wsdl = new_resource.wsdl
    password = new_resource.password
    file_inspection_use_mgmt_port = new_resource.file_inspection_use_mgmt_port
    ssl_key = new_resource.ssl_key
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    to_device = new_resource.to_device
    user_tag = new_resource.user_tag
    store_name = new_resource.store_name
    ca_cert = new_resource.ca_cert
    glm_cert = new_resource.glm_cert
    store = new_resource.store
    xml_schema = new_resource.xml_schema
    certificate_type = new_resource.certificate_type
    auth_saml_idp = new_resource.auth_saml_idp
    ssl_cert = new_resource.ssl_cert
    dnssec_dnskey = new_resource.dnssec_dnskey

    params = { "import": {"geo-location": geo_location,
        "ssl-cert-key": ssl_cert_key,
        "class-list-convert": class_list_convert,
        "bw-list": bw_list,
        "usb-license": usb_license,
        "health-external": health_external,
        "auth-portal": auth_portal,
        "aflex": aflex,
        "overwrite": overwrite,
        "class-list-type": class_list_type,
        "pfx-password": pfx_password,
        "web-category-license": web_category_license,
        "thales-kmdata": thales_kmdata,
        "ssl-crl": ssl_crl,
        "terminal": terminal,
        "policy": policy,
        "file-inspection-bw-list": file_inspection_bw_list,
        "thales-secworld": thales_secworld,
        "lw-4o6": lw_4o6,
        "auth-portal-image": auth_portal_image,
        "health-postfile": health_postfile,
        "class-list": class_list,
        "glm-license": glm_license,
        "dnssec-ds": dnssec_ds,
        "local-uri-file": local_uri_file,
        "wsdl": wsdl,
        "password": password,
        "file-inspection-use-mgmt-port": file_inspection_use_mgmt_port,
        "ssl-key": ssl_key,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "to-device": to_device,
        "user-tag": user_tag,
        "store-name": store_name,
        "ca-cert": ca_cert,
        "glm-cert": glm_cert,
        "store": store,
        "xml-schema": xml_schema,
        "certificate-type": certificate_type,
        "auth-saml-idp": auth_saml_idp,
        "ssl-cert": ssl_cert,
        "dnssec-dnskey": dnssec_dnskey,} }

    params[:"import"].each do |k, v|
        if not v 
            params[:"import"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating import') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import"
    geo_location = new_resource.geo_location
    ssl_cert_key = new_resource.ssl_cert_key
    class_list_convert = new_resource.class_list_convert
    bw_list = new_resource.bw_list
    usb_license = new_resource.usb_license
    health_external = new_resource.health_external
    auth_portal = new_resource.auth_portal
    aflex = new_resource.aflex
    overwrite = new_resource.overwrite
    class_list_type = new_resource.class_list_type
    pfx_password = new_resource.pfx_password
    web_category_license = new_resource.web_category_license
    thales_kmdata = new_resource.thales_kmdata
    ssl_crl = new_resource.ssl_crl
    terminal = new_resource.terminal
    policy = new_resource.policy
    file_inspection_bw_list = new_resource.file_inspection_bw_list
    thales_secworld = new_resource.thales_secworld
    lw_4o6 = new_resource.lw_4o6
    auth_portal_image = new_resource.auth_portal_image
    health_postfile = new_resource.health_postfile
    class_list = new_resource.class_list
    glm_license = new_resource.glm_license
    dnssec_ds = new_resource.dnssec_ds
    local_uri_file = new_resource.local_uri_file
    wsdl = new_resource.wsdl
    password = new_resource.password
    file_inspection_use_mgmt_port = new_resource.file_inspection_use_mgmt_port
    ssl_key = new_resource.ssl_key
    use_mgmt_port = new_resource.use_mgmt_port
    remote_file = new_resource.remote_file
    to_device = new_resource.to_device
    user_tag = new_resource.user_tag
    store_name = new_resource.store_name
    ca_cert = new_resource.ca_cert
    glm_cert = new_resource.glm_cert
    store = new_resource.store
    xml_schema = new_resource.xml_schema
    certificate_type = new_resource.certificate_type
    auth_saml_idp = new_resource.auth_saml_idp
    ssl_cert = new_resource.ssl_cert
    dnssec_dnskey = new_resource.dnssec_dnskey

    params = { "import": {"geo-location": geo_location,
        "ssl-cert-key": ssl_cert_key,
        "class-list-convert": class_list_convert,
        "bw-list": bw_list,
        "usb-license": usb_license,
        "health-external": health_external,
        "auth-portal": auth_portal,
        "aflex": aflex,
        "overwrite": overwrite,
        "class-list-type": class_list_type,
        "pfx-password": pfx_password,
        "web-category-license": web_category_license,
        "thales-kmdata": thales_kmdata,
        "ssl-crl": ssl_crl,
        "terminal": terminal,
        "policy": policy,
        "file-inspection-bw-list": file_inspection_bw_list,
        "thales-secworld": thales_secworld,
        "lw-4o6": lw_4o6,
        "auth-portal-image": auth_portal_image,
        "health-postfile": health_postfile,
        "class-list": class_list,
        "glm-license": glm_license,
        "dnssec-ds": dnssec_ds,
        "local-uri-file": local_uri_file,
        "wsdl": wsdl,
        "password": password,
        "file-inspection-use-mgmt-port": file_inspection_use_mgmt_port,
        "ssl-key": ssl_key,
        "use-mgmt-port": use_mgmt_port,
        "remote-file": remote_file,
        "to-device": to_device,
        "user-tag": user_tag,
        "store-name": store_name,
        "ca-cert": ca_cert,
        "glm-cert": glm_cert,
        "store": store,
        "xml-schema": xml_schema,
        "certificate-type": certificate_type,
        "auth-saml-idp": auth_saml_idp,
        "ssl-cert": ssl_cert,
        "dnssec-dnskey": dnssec_dnskey,} }

    params[:"import"].each do |k, v|
        if not v
            params[:"import"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["import"].each do |k, v|
        if v != params[:"import"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating import') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/import"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting import') do
            client.delete(url)
        end
    end
end