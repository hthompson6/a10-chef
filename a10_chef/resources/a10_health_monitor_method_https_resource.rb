resource_name :a10_health_monitor_method_https

property :a10_name, String, name_property: true
property :https_kerberos_realm, String
property :text_regex, String
property :response_code_regex, String
property :uuid, String
property :post_type, ['postdata','postfile']
property :https_kerberos_auth, [true, false]
property :https_username, String
property :key_phrase, String
property :https_postdata, String
property :https_key_encrypted, String
property :https_expect, [true, false]
property :https, [true, false]
property :https_host, String
property :key_pass_phrase, [true, false]
property :https_encrypted, String
property :url_type, ['GET','POST','HEAD']
property :web_port, Integer
property :disable_sslv2hello, [true, false]
property :https_kerberos_kdc, Hash
property :key, String
property :https_password_string, String
property :post_path, String
property :https_postfile, String
property :https_password, [true, false]
property :cert, String
property :https_text, String
property :https_response_code, String
property :url_path, String
property :https_maintenance_code, String
property :https_url, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/https"
    https_kerberos_realm = new_resource.https_kerberos_realm
    text_regex = new_resource.text_regex
    response_code_regex = new_resource.response_code_regex
    uuid = new_resource.uuid
    post_type = new_resource.post_type
    https_kerberos_auth = new_resource.https_kerberos_auth
    https_username = new_resource.https_username
    key_phrase = new_resource.key_phrase
    https_postdata = new_resource.https_postdata
    https_key_encrypted = new_resource.https_key_encrypted
    https_expect = new_resource.https_expect
    https = new_resource.https
    https_host = new_resource.https_host
    key_pass_phrase = new_resource.key_pass_phrase
    https_encrypted = new_resource.https_encrypted
    url_type = new_resource.url_type
    web_port = new_resource.web_port
    disable_sslv2hello = new_resource.disable_sslv2hello
    https_kerberos_kdc = new_resource.https_kerberos_kdc
    key = new_resource.key
    https_password_string = new_resource.https_password_string
    post_path = new_resource.post_path
    https_postfile = new_resource.https_postfile
    https_password = new_resource.https_password
    cert = new_resource.cert
    https_text = new_resource.https_text
    https_response_code = new_resource.https_response_code
    url_path = new_resource.url_path
    https_maintenance_code = new_resource.https_maintenance_code
    https_url = new_resource.https_url

    params = { "https": {"https-kerberos-realm": https_kerberos_realm,
        "text-regex": text_regex,
        "response-code-regex": response_code_regex,
        "uuid": uuid,
        "post-type": post_type,
        "https-kerberos-auth": https_kerberos_auth,
        "https-username": https_username,
        "key-phrase": key_phrase,
        "https-postdata": https_postdata,
        "https-key-encrypted": https_key_encrypted,
        "https-expect": https_expect,
        "https": https,
        "https-host": https_host,
        "key-pass-phrase": key_pass_phrase,
        "https-encrypted": https_encrypted,
        "url-type": url_type,
        "web-port": web_port,
        "disable-sslv2hello": disable_sslv2hello,
        "https-kerberos-kdc": https_kerberos_kdc,
        "key": key,
        "https-password-string": https_password_string,
        "post-path": post_path,
        "https-postfile": https_postfile,
        "https-password": https_password,
        "cert": cert,
        "https-text": https_text,
        "https-response-code": https_response_code,
        "url-path": url_path,
        "https-maintenance-code": https_maintenance_code,
        "https-url": https_url,} }

    params[:"https"].each do |k, v|
        if not v 
            params[:"https"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating https') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/https"
    https_kerberos_realm = new_resource.https_kerberos_realm
    text_regex = new_resource.text_regex
    response_code_regex = new_resource.response_code_regex
    uuid = new_resource.uuid
    post_type = new_resource.post_type
    https_kerberos_auth = new_resource.https_kerberos_auth
    https_username = new_resource.https_username
    key_phrase = new_resource.key_phrase
    https_postdata = new_resource.https_postdata
    https_key_encrypted = new_resource.https_key_encrypted
    https_expect = new_resource.https_expect
    https = new_resource.https
    https_host = new_resource.https_host
    key_pass_phrase = new_resource.key_pass_phrase
    https_encrypted = new_resource.https_encrypted
    url_type = new_resource.url_type
    web_port = new_resource.web_port
    disable_sslv2hello = new_resource.disable_sslv2hello
    https_kerberos_kdc = new_resource.https_kerberos_kdc
    key = new_resource.key
    https_password_string = new_resource.https_password_string
    post_path = new_resource.post_path
    https_postfile = new_resource.https_postfile
    https_password = new_resource.https_password
    cert = new_resource.cert
    https_text = new_resource.https_text
    https_response_code = new_resource.https_response_code
    url_path = new_resource.url_path
    https_maintenance_code = new_resource.https_maintenance_code
    https_url = new_resource.https_url

    params = { "https": {"https-kerberos-realm": https_kerberos_realm,
        "text-regex": text_regex,
        "response-code-regex": response_code_regex,
        "uuid": uuid,
        "post-type": post_type,
        "https-kerberos-auth": https_kerberos_auth,
        "https-username": https_username,
        "key-phrase": key_phrase,
        "https-postdata": https_postdata,
        "https-key-encrypted": https_key_encrypted,
        "https-expect": https_expect,
        "https": https,
        "https-host": https_host,
        "key-pass-phrase": key_pass_phrase,
        "https-encrypted": https_encrypted,
        "url-type": url_type,
        "web-port": web_port,
        "disable-sslv2hello": disable_sslv2hello,
        "https-kerberos-kdc": https_kerberos_kdc,
        "key": key,
        "https-password-string": https_password_string,
        "post-path": post_path,
        "https-postfile": https_postfile,
        "https-password": https_password,
        "cert": cert,
        "https-text": https_text,
        "https-response-code": https_response_code,
        "url-path": url_path,
        "https-maintenance-code": https_maintenance_code,
        "https-url": https_url,} }

    params[:"https"].each do |k, v|
        if not v
            params[:"https"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["https"].each do |k, v|
        if v != params[:"https"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating https') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/https"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting https') do
            client.delete(url)
        end
    end
end