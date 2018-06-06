resource_name :a10_slb_template_logging

property :a10_name, String, name_property: true
property :format, String
property :auto, ['auto']
property :keep_end, Integer
property :local_logging, Integer
property :mask, String
property :user_tag, String
property :keep_start, Integer
property :service_group, String
property :pcre_mask, String
property :tcp_proxy, String
property :pool, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/logging/"
    get_url = "/axapi/v3/slb/template/logging/%<name>s"
    a10_name = new_resource.a10_name
    format = new_resource.format
    auto = new_resource.auto
    keep_end = new_resource.keep_end
    local_logging = new_resource.local_logging
    mask = new_resource.mask
    user_tag = new_resource.user_tag
    keep_start = new_resource.keep_start
    service_group = new_resource.service_group
    pcre_mask = new_resource.pcre_mask
    tcp_proxy = new_resource.tcp_proxy
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "logging": {"name": a10_name,
        "format": format,
        "auto": auto,
        "keep-end": keep_end,
        "local-logging": local_logging,
        "mask": mask,
        "user-tag": user_tag,
        "keep-start": keep_start,
        "service-group": service_group,
        "pcre-mask": pcre_mask,
        "tcp-proxy": tcp_proxy,
        "pool": pool,
        "uuid": uuid,} }

    params[:"logging"].each do |k, v|
        if not v 
            params[:"logging"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating logging') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/logging/%<name>s"
    a10_name = new_resource.a10_name
    format = new_resource.format
    auto = new_resource.auto
    keep_end = new_resource.keep_end
    local_logging = new_resource.local_logging
    mask = new_resource.mask
    user_tag = new_resource.user_tag
    keep_start = new_resource.keep_start
    service_group = new_resource.service_group
    pcre_mask = new_resource.pcre_mask
    tcp_proxy = new_resource.tcp_proxy
    pool = new_resource.pool
    uuid = new_resource.uuid

    params = { "logging": {"name": a10_name,
        "format": format,
        "auto": auto,
        "keep-end": keep_end,
        "local-logging": local_logging,
        "mask": mask,
        "user-tag": user_tag,
        "keep-start": keep_start,
        "service-group": service_group,
        "pcre-mask": pcre_mask,
        "tcp-proxy": tcp_proxy,
        "pool": pool,
        "uuid": uuid,} }

    params[:"logging"].each do |k, v|
        if not v
            params[:"logging"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["logging"].each do |k, v|
        if v != params[:"logging"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating logging') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/logging/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logging') do
            client.delete(url)
        end
    end
end