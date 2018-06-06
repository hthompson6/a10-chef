resource_name :a10_cgnv6_dns64_virtualserver

property :a10_name, String, name_property: true
property :use_if_ip, [true, false]
property :port_list, Array
property :template_policy, String
property :vrid, Integer
property :enable_disable_action, ['enable','disable']
property :user_tag, String
property :ipv6_address, String
property :netmask, String
property :ip_address, String
property :policy, [true, false]
property :ethernet, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/dns64-virtualserver/"
    get_url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s"
    use_if_ip = new_resource.use_if_ip
    port_list = new_resource.port_list
    a10_name = new_resource.a10_name
    template_policy = new_resource.template_policy
    vrid = new_resource.vrid
    enable_disable_action = new_resource.enable_disable_action
    user_tag = new_resource.user_tag
    ipv6_address = new_resource.ipv6_address
    netmask = new_resource.netmask
    ip_address = new_resource.ip_address
    policy = new_resource.policy
    ethernet = new_resource.ethernet
    uuid = new_resource.uuid

    params = { "dns64-virtualserver": {"use-if-ip": use_if_ip,
        "port-list": port_list,
        "name": a10_name,
        "template-policy": template_policy,
        "vrid": vrid,
        "enable-disable-action": enable_disable_action,
        "user-tag": user_tag,
        "ipv6-address": ipv6_address,
        "netmask": netmask,
        "ip-address": ip_address,
        "policy": policy,
        "ethernet": ethernet,
        "uuid": uuid,} }

    params[:"dns64-virtualserver"].each do |k, v|
        if not v 
            params[:"dns64-virtualserver"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns64-virtualserver') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s"
    use_if_ip = new_resource.use_if_ip
    port_list = new_resource.port_list
    a10_name = new_resource.a10_name
    template_policy = new_resource.template_policy
    vrid = new_resource.vrid
    enable_disable_action = new_resource.enable_disable_action
    user_tag = new_resource.user_tag
    ipv6_address = new_resource.ipv6_address
    netmask = new_resource.netmask
    ip_address = new_resource.ip_address
    policy = new_resource.policy
    ethernet = new_resource.ethernet
    uuid = new_resource.uuid

    params = { "dns64-virtualserver": {"use-if-ip": use_if_ip,
        "port-list": port_list,
        "name": a10_name,
        "template-policy": template_policy,
        "vrid": vrid,
        "enable-disable-action": enable_disable_action,
        "user-tag": user_tag,
        "ipv6-address": ipv6_address,
        "netmask": netmask,
        "ip-address": ip_address,
        "policy": policy,
        "ethernet": ethernet,
        "uuid": uuid,} }

    params[:"dns64-virtualserver"].each do |k, v|
        if not v
            params[:"dns64-virtualserver"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns64-virtualserver"].each do |k, v|
        if v != params[:"dns64-virtualserver"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns64-virtualserver') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns64-virtualserver') do
            client.delete(url)
        end
    end
end