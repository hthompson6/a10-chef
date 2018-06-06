resource_name :a10_slb_template_persist_cookie

property :a10_name, String, name_property: true
property :pass_phrase, String
property :domain, String
property :cookie_name, String
property :secure, [true, false]
property :encrypted, String
property :dont_honor_conn_rules, [true, false]
property :encrypt_level, Integer
property :uuid, String
property :user_tag, String
property :server, [true, false]
property :server_service_group, [true, false]
property :service_group, [true, false]
property :expire, Integer
property :httponly, [true, false]
property :path, String
property :pass_thru, [true, false]
property :scan_all_members, [true, false]
property :insert_always, [true, false]
property :match_type, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/persist/cookie/"
    get_url = "/axapi/v3/slb/template/persist/cookie/%<name>s"
    pass_phrase = new_resource.pass_phrase
    domain = new_resource.domain
    cookie_name = new_resource.cookie_name
    secure = new_resource.secure
    encrypted = new_resource.encrypted
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    encrypt_level = new_resource.encrypt_level
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    server = new_resource.server
    server_service_group = new_resource.server_service_group
    service_group = new_resource.service_group
    expire = new_resource.expire
    httponly = new_resource.httponly
    path = new_resource.path
    pass_thru = new_resource.pass_thru
    scan_all_members = new_resource.scan_all_members
    insert_always = new_resource.insert_always
    match_type = new_resource.match_type
    a10_name = new_resource.a10_name

    params = { "cookie": {"pass-phrase": pass_phrase,
        "domain": domain,
        "cookie-name": cookie_name,
        "secure": secure,
        "encrypted": encrypted,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "encrypt-level": encrypt_level,
        "uuid": uuid,
        "user-tag": user_tag,
        "server": server,
        "server-service-group": server_service_group,
        "service-group": service_group,
        "expire": expire,
        "httponly": httponly,
        "path": path,
        "pass-thru": pass_thru,
        "scan-all-members": scan_all_members,
        "insert-always": insert_always,
        "match-type": match_type,
        "name": a10_name,} }

    params[:"cookie"].each do |k, v|
        if not v 
            params[:"cookie"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cookie') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/cookie/%<name>s"
    pass_phrase = new_resource.pass_phrase
    domain = new_resource.domain
    cookie_name = new_resource.cookie_name
    secure = new_resource.secure
    encrypted = new_resource.encrypted
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    encrypt_level = new_resource.encrypt_level
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    server = new_resource.server
    server_service_group = new_resource.server_service_group
    service_group = new_resource.service_group
    expire = new_resource.expire
    httponly = new_resource.httponly
    path = new_resource.path
    pass_thru = new_resource.pass_thru
    scan_all_members = new_resource.scan_all_members
    insert_always = new_resource.insert_always
    match_type = new_resource.match_type
    a10_name = new_resource.a10_name

    params = { "cookie": {"pass-phrase": pass_phrase,
        "domain": domain,
        "cookie-name": cookie_name,
        "secure": secure,
        "encrypted": encrypted,
        "dont-honor-conn-rules": dont_honor_conn_rules,
        "encrypt-level": encrypt_level,
        "uuid": uuid,
        "user-tag": user_tag,
        "server": server,
        "server-service-group": server_service_group,
        "service-group": service_group,
        "expire": expire,
        "httponly": httponly,
        "path": path,
        "pass-thru": pass_thru,
        "scan-all-members": scan_all_members,
        "insert-always": insert_always,
        "match-type": match_type,
        "name": a10_name,} }

    params[:"cookie"].each do |k, v|
        if not v
            params[:"cookie"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cookie"].each do |k, v|
        if v != params[:"cookie"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cookie') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/cookie/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cookie') do
            client.delete(url)
        end
    end
end