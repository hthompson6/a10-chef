resource_name :a10_cgnv6_template_dns

property :a10_name, String, name_property: true
property :class_list, Hash
property :dns64, Hash
property :drop, [true, false]
property :period, Integer
property :user_tag, String
property :default_policy, ['nocache','cache']
property :disable_dns_template, [true, false]
property :forward, String
property :max_cache_size, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/dns/"
    get_url = "/axapi/v3/cgnv6/template/dns/%<name>s"
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    dns64 = new_resource.dns64
    drop = new_resource.drop
    period = new_resource.period
    user_tag = new_resource.user_tag
    default_policy = new_resource.default_policy
    disable_dns_template = new_resource.disable_dns_template
    forward = new_resource.forward
    max_cache_size = new_resource.max_cache_size
    uuid = new_resource.uuid

    params = { "dns": {"name": a10_name,
        "class-list": class_list,
        "dns64": dns64,
        "drop": drop,
        "period": period,
        "user-tag": user_tag,
        "default-policy": default_policy,
        "disable-dns-template": disable_dns_template,
        "forward": forward,
        "max-cache-size": max_cache_size,
        "uuid": uuid,} }

    params[:"dns"].each do |k, v|
        if not v 
            params[:"dns"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s"
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    dns64 = new_resource.dns64
    drop = new_resource.drop
    period = new_resource.period
    user_tag = new_resource.user_tag
    default_policy = new_resource.default_policy
    disable_dns_template = new_resource.disable_dns_template
    forward = new_resource.forward
    max_cache_size = new_resource.max_cache_size
    uuid = new_resource.uuid

    params = { "dns": {"name": a10_name,
        "class-list": class_list,
        "dns64": dns64,
        "drop": drop,
        "period": period,
        "user-tag": user_tag,
        "default-policy": default_policy,
        "disable-dns-template": disable_dns_template,
        "forward": forward,
        "max-cache-size": max_cache_size,
        "uuid": uuid,} }

    params[:"dns"].each do |k, v|
        if not v
            params[:"dns"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns"].each do |k, v|
        if v != params[:"dns"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns') do
            client.delete(url)
        end
    end
end