resource_name :a10_slb_template_cache

property :a10_name, String, name_property: true
property :accept_reload_req, [true, false]
property :default_policy_nocache, [true, false]
property :age, Integer
property :disable_insert_via, [true, false]
property :user_tag, String
property :local_uri_policy, Array
property :sampling_enable, Array
property :replacement_policy, ['LFU']
property :disable_insert_age, [true, false]
property :max_content_size, Integer
property :max_cache_size, Integer
property :logging, String
property :uri_policy, Array
property :remove_cookies, [true, false]
property :verify_host, [true, false]
property :min_content_size, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/cache/"
    get_url = "/axapi/v3/slb/template/cache/%<name>s"
    accept_reload_req = new_resource.accept_reload_req
    a10_name = new_resource.a10_name
    default_policy_nocache = new_resource.default_policy_nocache
    age = new_resource.age
    disable_insert_via = new_resource.disable_insert_via
    user_tag = new_resource.user_tag
    local_uri_policy = new_resource.local_uri_policy
    sampling_enable = new_resource.sampling_enable
    replacement_policy = new_resource.replacement_policy
    disable_insert_age = new_resource.disable_insert_age
    max_content_size = new_resource.max_content_size
    max_cache_size = new_resource.max_cache_size
    logging = new_resource.logging
    uri_policy = new_resource.uri_policy
    remove_cookies = new_resource.remove_cookies
    verify_host = new_resource.verify_host
    min_content_size = new_resource.min_content_size
    uuid = new_resource.uuid

    params = { "cache": {"accept-reload-req": accept_reload_req,
        "name": a10_name,
        "default-policy-nocache": default_policy_nocache,
        "age": age,
        "disable-insert-via": disable_insert_via,
        "user-tag": user_tag,
        "local-uri-policy": local_uri_policy,
        "sampling-enable": sampling_enable,
        "replacement-policy": replacement_policy,
        "disable-insert-age": disable_insert_age,
        "max-content-size": max_content_size,
        "max-cache-size": max_cache_size,
        "logging": logging,
        "uri-policy": uri_policy,
        "remove-cookies": remove_cookies,
        "verify-host": verify_host,
        "min-content-size": min_content_size,
        "uuid": uuid,} }

    params[:"cache"].each do |k, v|
        if not v 
            params[:"cache"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cache') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/cache/%<name>s"
    accept_reload_req = new_resource.accept_reload_req
    a10_name = new_resource.a10_name
    default_policy_nocache = new_resource.default_policy_nocache
    age = new_resource.age
    disable_insert_via = new_resource.disable_insert_via
    user_tag = new_resource.user_tag
    local_uri_policy = new_resource.local_uri_policy
    sampling_enable = new_resource.sampling_enable
    replacement_policy = new_resource.replacement_policy
    disable_insert_age = new_resource.disable_insert_age
    max_content_size = new_resource.max_content_size
    max_cache_size = new_resource.max_cache_size
    logging = new_resource.logging
    uri_policy = new_resource.uri_policy
    remove_cookies = new_resource.remove_cookies
    verify_host = new_resource.verify_host
    min_content_size = new_resource.min_content_size
    uuid = new_resource.uuid

    params = { "cache": {"accept-reload-req": accept_reload_req,
        "name": a10_name,
        "default-policy-nocache": default_policy_nocache,
        "age": age,
        "disable-insert-via": disable_insert_via,
        "user-tag": user_tag,
        "local-uri-policy": local_uri_policy,
        "sampling-enable": sampling_enable,
        "replacement-policy": replacement_policy,
        "disable-insert-age": disable_insert_age,
        "max-content-size": max_content_size,
        "max-cache-size": max_cache_size,
        "logging": logging,
        "uri-policy": uri_policy,
        "remove-cookies": remove_cookies,
        "verify-host": verify_host,
        "min-content-size": min_content_size,
        "uuid": uuid,} }

    params[:"cache"].each do |k, v|
        if not v
            params[:"cache"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cache"].each do |k, v|
        if v != params[:"cache"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cache') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/cache/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cache') do
            client.delete(url)
        end
    end
end