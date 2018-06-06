resource_name :a10_slb_template_dns

property :a10_name, String, name_property: true
property :dnssec_service_group, String
property :class_list, Hash
property :default_policy, ['nocache','cache']
property :drop, [true, false]
property :period, Integer
property :user_tag, String
property :query_id_switch, [true, false]
property :enable_cache_sharing, [true, false]
property :redirect_to_tcp_port, [true, false]
property :max_query_length, Integer
property :disable_dns_template, [true, false]
property :forward, String
property :max_cache_size, Integer
property :max_cache_entry_size, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/dns/"
    get_url = "/axapi/v3/slb/template/dns/%<name>s"
    dnssec_service_group = new_resource.dnssec_service_group
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    default_policy = new_resource.default_policy
    drop = new_resource.drop
    period = new_resource.period
    user_tag = new_resource.user_tag
    query_id_switch = new_resource.query_id_switch
    enable_cache_sharing = new_resource.enable_cache_sharing
    redirect_to_tcp_port = new_resource.redirect_to_tcp_port
    max_query_length = new_resource.max_query_length
    disable_dns_template = new_resource.disable_dns_template
    forward = new_resource.forward
    max_cache_size = new_resource.max_cache_size
    max_cache_entry_size = new_resource.max_cache_entry_size
    uuid = new_resource.uuid

    params = { "dns": {"dnssec-service-group": dnssec_service_group,
        "name": a10_name,
        "class-list": class_list,
        "default-policy": default_policy,
        "drop": drop,
        "period": period,
        "user-tag": user_tag,
        "query-id-switch": query_id_switch,
        "enable-cache-sharing": enable_cache_sharing,
        "redirect-to-tcp-port": redirect_to_tcp_port,
        "max-query-length": max_query_length,
        "disable-dns-template": disable_dns_template,
        "forward": forward,
        "max-cache-size": max_cache_size,
        "max-cache-entry-size": max_cache_entry_size,
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
    url = "/axapi/v3/slb/template/dns/%<name>s"
    dnssec_service_group = new_resource.dnssec_service_group
    a10_name = new_resource.a10_name
    class_list = new_resource.class_list
    default_policy = new_resource.default_policy
    drop = new_resource.drop
    period = new_resource.period
    user_tag = new_resource.user_tag
    query_id_switch = new_resource.query_id_switch
    enable_cache_sharing = new_resource.enable_cache_sharing
    redirect_to_tcp_port = new_resource.redirect_to_tcp_port
    max_query_length = new_resource.max_query_length
    disable_dns_template = new_resource.disable_dns_template
    forward = new_resource.forward
    max_cache_size = new_resource.max_cache_size
    max_cache_entry_size = new_resource.max_cache_entry_size
    uuid = new_resource.uuid

    params = { "dns": {"dnssec-service-group": dnssec_service_group,
        "name": a10_name,
        "class-list": class_list,
        "default-policy": default_policy,
        "drop": drop,
        "period": period,
        "user-tag": user_tag,
        "query-id-switch": query_id_switch,
        "enable-cache-sharing": enable_cache_sharing,
        "redirect-to-tcp-port": redirect_to_tcp_port,
        "max-query-length": max_query_length,
        "disable-dns-template": disable_dns_template,
        "forward": forward,
        "max-cache-size": max_cache_size,
        "max-cache-entry-size": max_cache_entry_size,
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
    url = "/axapi/v3/slb/template/dns/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns') do
            client.delete(url)
        end
    end
end