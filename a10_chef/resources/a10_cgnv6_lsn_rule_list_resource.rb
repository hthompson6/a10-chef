resource_name :a10_cgnv6_lsn_rule_list

property :a10_name, String, name_property: true
property :uuid, String
property :domain_ip, Hash
property :default, Hash
property :user_tag, String
property :ip_list, Array
property :domain_list_name_list, Array
property :domain_name_list, Array
property :http_match_domain_name, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-rule-list/"
    get_url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s"
    uuid = new_resource.uuid
    domain_ip = new_resource.domain_ip
    default = new_resource.default
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    ip_list = new_resource.ip_list
    domain_list_name_list = new_resource.domain_list_name_list
    domain_name_list = new_resource.domain_name_list
    http_match_domain_name = new_resource.http_match_domain_name

    params = { "lsn-rule-list": {"uuid": uuid,
        "domain-ip": domain_ip,
        "default": default,
        "user-tag": user_tag,
        "name": a10_name,
        "ip-list": ip_list,
        "domain-list-name-list": domain_list_name_list,
        "domain-name-list": domain_name_list,
        "http-match-domain-name": http_match_domain_name,} }

    params[:"lsn-rule-list"].each do |k, v|
        if not v 
            params[:"lsn-rule-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lsn-rule-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s"
    uuid = new_resource.uuid
    domain_ip = new_resource.domain_ip
    default = new_resource.default
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    ip_list = new_resource.ip_list
    domain_list_name_list = new_resource.domain_list_name_list
    domain_name_list = new_resource.domain_name_list
    http_match_domain_name = new_resource.http_match_domain_name

    params = { "lsn-rule-list": {"uuid": uuid,
        "domain-ip": domain_ip,
        "default": default,
        "user-tag": user_tag,
        "name": a10_name,
        "ip-list": ip_list,
        "domain-list-name-list": domain_list_name_list,
        "domain-name-list": domain_name_list,
        "http-match-domain-name": http_match_domain_name,} }

    params[:"lsn-rule-list"].each do |k, v|
        if not v
            params[:"lsn-rule-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lsn-rule-list"].each do |k, v|
        if v != params[:"lsn-rule-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lsn-rule-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-rule-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lsn-rule-list') do
            client.delete(url)
        end
    end
end