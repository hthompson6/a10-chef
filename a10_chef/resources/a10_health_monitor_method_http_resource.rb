resource_name :a10_health_monitor_method_http

property :a10_name, String, name_property: true
property :http_url, [true, false]
property :text_regex, String
property :http_maintenance_code, String
property :http_kerberos_auth, [true, false]
property :http_postfile, String
property :response_code_regex, String
property :uuid, String
property :post_type, ['postdata','postfile']
property :http_password_string, String
property :url_path, String
property :http_response_code, String
property :http_host, String
property :http, [true, false]
property :url_type, ['GET','POST','HEAD']
property :http_postdata, String
property :http_text, String
property :http_encrypted, String
property :http_kerberos_realm, String
property :http_password, [true, false]
property :http_kerberos_kdc, Hash
property :http_expect, [true, false]
property :post_path, String
property :http_username, String
property :http_port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/http"
    http_url = new_resource.http_url
    text_regex = new_resource.text_regex
    http_maintenance_code = new_resource.http_maintenance_code
    http_kerberos_auth = new_resource.http_kerberos_auth
    http_postfile = new_resource.http_postfile
    response_code_regex = new_resource.response_code_regex
    uuid = new_resource.uuid
    post_type = new_resource.post_type
    http_password_string = new_resource.http_password_string
    url_path = new_resource.url_path
    http_response_code = new_resource.http_response_code
    http_host = new_resource.http_host
    http = new_resource.http
    url_type = new_resource.url_type
    http_postdata = new_resource.http_postdata
    http_text = new_resource.http_text
    http_encrypted = new_resource.http_encrypted
    http_kerberos_realm = new_resource.http_kerberos_realm
    http_password = new_resource.http_password
    http_kerberos_kdc = new_resource.http_kerberos_kdc
    http_expect = new_resource.http_expect
    post_path = new_resource.post_path
    http_username = new_resource.http_username
    http_port = new_resource.http_port

    params = { "http": {"http-url": http_url,
        "text-regex": text_regex,
        "http-maintenance-code": http_maintenance_code,
        "http-kerberos-auth": http_kerberos_auth,
        "http-postfile": http_postfile,
        "response-code-regex": response_code_regex,
        "uuid": uuid,
        "post-type": post_type,
        "http-password-string": http_password_string,
        "url-path": url_path,
        "http-response-code": http_response_code,
        "http-host": http_host,
        "http": http,
        "url-type": url_type,
        "http-postdata": http_postdata,
        "http-text": http_text,
        "http-encrypted": http_encrypted,
        "http-kerberos-realm": http_kerberos_realm,
        "http-password": http_password,
        "http-kerberos-kdc": http_kerberos_kdc,
        "http-expect": http_expect,
        "post-path": post_path,
        "http-username": http_username,
        "http-port": http_port,} }

    params[:"http"].each do |k, v|
        if not v 
            params[:"http"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/http"
    http_url = new_resource.http_url
    text_regex = new_resource.text_regex
    http_maintenance_code = new_resource.http_maintenance_code
    http_kerberos_auth = new_resource.http_kerberos_auth
    http_postfile = new_resource.http_postfile
    response_code_regex = new_resource.response_code_regex
    uuid = new_resource.uuid
    post_type = new_resource.post_type
    http_password_string = new_resource.http_password_string
    url_path = new_resource.url_path
    http_response_code = new_resource.http_response_code
    http_host = new_resource.http_host
    http = new_resource.http
    url_type = new_resource.url_type
    http_postdata = new_resource.http_postdata
    http_text = new_resource.http_text
    http_encrypted = new_resource.http_encrypted
    http_kerberos_realm = new_resource.http_kerberos_realm
    http_password = new_resource.http_password
    http_kerberos_kdc = new_resource.http_kerberos_kdc
    http_expect = new_resource.http_expect
    post_path = new_resource.post_path
    http_username = new_resource.http_username
    http_port = new_resource.http_port

    params = { "http": {"http-url": http_url,
        "text-regex": text_regex,
        "http-maintenance-code": http_maintenance_code,
        "http-kerberos-auth": http_kerberos_auth,
        "http-postfile": http_postfile,
        "response-code-regex": response_code_regex,
        "uuid": uuid,
        "post-type": post_type,
        "http-password-string": http_password_string,
        "url-path": url_path,
        "http-response-code": http_response_code,
        "http-host": http_host,
        "http": http,
        "url-type": url_type,
        "http-postdata": http_postdata,
        "http-text": http_text,
        "http-encrypted": http_encrypted,
        "http-kerberos-realm": http_kerberos_realm,
        "http-password": http_password,
        "http-kerberos-kdc": http_kerberos_kdc,
        "http-expect": http_expect,
        "post-path": post_path,
        "http-username": http_username,
        "http-port": http_port,} }

    params[:"http"].each do |k, v|
        if not v
            params[:"http"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http"].each do |k, v|
        if v != params[:"http"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/http"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http') do
            client.delete(url)
        end
    end
end