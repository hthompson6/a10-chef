resource_name :a10_cgnv6_dns64_virtualserver_port

property :a10_name, String, name_property: true
property :protocol, ['dns-udp'],required: true
property :uuid, String
property :precedence, [true, false]
property :auto, [true, false]
property :template_policy, String
property :service_group, String
property :port_number, Integer,required: true
property :a10_action, ['enable','disable']
property :sampling_enable, Array
property :user_tag, String
property :template_dns, String
property :pool, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s/port/"
    get_url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s/port/%<port-number>s+%<protocol>s"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    precedence = new_resource.precedence
    auto = new_resource.auto
    template_policy = new_resource.template_policy
    service_group = new_resource.service_group
    port_number = new_resource.port_number
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    template_dns = new_resource.template_dns
    pool = new_resource.pool

    params = { "port": {"protocol": protocol,
        "uuid": uuid,
        "precedence": precedence,
        "auto": auto,
        "template-policy": template_policy,
        "service-group": service_group,
        "port-number": port_number,
        "action": a10_action,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "template-dns": template_dns,
        "pool": pool,} }

    params[:"port"].each do |k, v|
        if not v 
            params[:"port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s/port/%<port-number>s+%<protocol>s"
    protocol = new_resource.protocol
    uuid = new_resource.uuid
    precedence = new_resource.precedence
    auto = new_resource.auto
    template_policy = new_resource.template_policy
    service_group = new_resource.service_group
    port_number = new_resource.port_number
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    user_tag = new_resource.user_tag
    template_dns = new_resource.template_dns
    pool = new_resource.pool

    params = { "port": {"protocol": protocol,
        "uuid": uuid,
        "precedence": precedence,
        "auto": auto,
        "template-policy": template_policy,
        "service-group": service_group,
        "port-number": port_number,
        "action": a10_action,
        "sampling-enable": sampling_enable,
        "user-tag": user_tag,
        "template-dns": template_dns,
        "pool": pool,} }

    params[:"port"].each do |k, v|
        if not v
            params[:"port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port"].each do |k, v|
        if v != params[:"port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/dns64-virtualserver/%<name>s/port/%<port-number>s+%<protocol>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port') do
            client.delete(url)
        end
    end
end