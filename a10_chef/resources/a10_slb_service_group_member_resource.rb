resource_name :a10_slb_service_group_member

property :a10_name, String, name_property: true
property :member_stats_data_disable, [true, false]
property :member_priority, Integer
property :fqdn_name, String
property :sampling_enable, Array
property :member_template, String
property :host, String
property :user_tag, String
property :member_state, ['enable','disable','disable-with-health-check']
property :server_ipv6_addr, String
property :port, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/service-group/%<name>s/member/"
    get_url = "/axapi/v3/slb/service-group/%<name>s/member/%<name>s+%<port>s"
    member_stats_data_disable = new_resource.member_stats_data_disable
    member_priority = new_resource.member_priority
    a10_name = new_resource.a10_name
    fqdn_name = new_resource.fqdn_name
    sampling_enable = new_resource.sampling_enable
    member_template = new_resource.member_template
    host = new_resource.host
    user_tag = new_resource.user_tag
    member_state = new_resource.member_state
    server_ipv6_addr = new_resource.server_ipv6_addr
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "member": {"member-stats-data-disable": member_stats_data_disable,
        "member-priority": member_priority,
        "name": a10_name,
        "fqdn-name": fqdn_name,
        "sampling-enable": sampling_enable,
        "member-template": member_template,
        "host": host,
        "user-tag": user_tag,
        "member-state": member_state,
        "server-ipv6-addr": server_ipv6_addr,
        "port": port,
        "uuid": uuid,} }

    params[:"member"].each do |k, v|
        if not v 
            params[:"member"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating member') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/service-group/%<name>s/member/%<name>s+%<port>s"
    member_stats_data_disable = new_resource.member_stats_data_disable
    member_priority = new_resource.member_priority
    a10_name = new_resource.a10_name
    fqdn_name = new_resource.fqdn_name
    sampling_enable = new_resource.sampling_enable
    member_template = new_resource.member_template
    host = new_resource.host
    user_tag = new_resource.user_tag
    member_state = new_resource.member_state
    server_ipv6_addr = new_resource.server_ipv6_addr
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "member": {"member-stats-data-disable": member_stats_data_disable,
        "member-priority": member_priority,
        "name": a10_name,
        "fqdn-name": fqdn_name,
        "sampling-enable": sampling_enable,
        "member-template": member_template,
        "host": host,
        "user-tag": user_tag,
        "member-state": member_state,
        "server-ipv6-addr": server_ipv6_addr,
        "port": port,
        "uuid": uuid,} }

    params[:"member"].each do |k, v|
        if not v
            params[:"member"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["member"].each do |k, v|
        if v != params[:"member"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating member') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/service-group/%<name>s/member/%<name>s+%<port>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting member') do
            client.delete(url)
        end
    end
end