resource_name :a10_interface_ve_ip_ospf_ospf_ip

property :a10_name, String, name_property: true
property :dead_interval, Integer
property :authentication_key, String
property :uuid, String
property :mtu_ignore, [true, false]
property :transmit_delay, Integer
property :value, ['message-digest','null']
property :priority, Integer
property :authentication, [true, false]
property :cost, Integer
property :database_filter, ['all']
property :hello_interval, Integer
property :ip_addr, String,required: true
property :retransmit_interval, Integer
property :message_digest_cfg, Array
property :out, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-ip/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-ip/%<ip-addr>s"
    dead_interval = new_resource.dead_interval
    authentication_key = new_resource.authentication_key
    uuid = new_resource.uuid
    mtu_ignore = new_resource.mtu_ignore
    transmit_delay = new_resource.transmit_delay
    value = new_resource.value
    priority = new_resource.priority
    authentication = new_resource.authentication
    cost = new_resource.cost
    database_filter = new_resource.database_filter
    hello_interval = new_resource.hello_interval
    ip_addr = new_resource.ip_addr
    retransmit_interval = new_resource.retransmit_interval
    message_digest_cfg = new_resource.message_digest_cfg
    out = new_resource.out

    params = { "ospf-ip": {"dead-interval": dead_interval,
        "authentication-key": authentication_key,
        "uuid": uuid,
        "mtu-ignore": mtu_ignore,
        "transmit-delay": transmit_delay,
        "value": value,
        "priority": priority,
        "authentication": authentication,
        "cost": cost,
        "database-filter": database_filter,
        "hello-interval": hello_interval,
        "ip-addr": ip_addr,
        "retransmit-interval": retransmit_interval,
        "message-digest-cfg": message_digest_cfg,
        "out": out,} }

    params[:"ospf-ip"].each do |k, v|
        if not v 
            params[:"ospf-ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf-ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-ip/%<ip-addr>s"
    dead_interval = new_resource.dead_interval
    authentication_key = new_resource.authentication_key
    uuid = new_resource.uuid
    mtu_ignore = new_resource.mtu_ignore
    transmit_delay = new_resource.transmit_delay
    value = new_resource.value
    priority = new_resource.priority
    authentication = new_resource.authentication
    cost = new_resource.cost
    database_filter = new_resource.database_filter
    hello_interval = new_resource.hello_interval
    ip_addr = new_resource.ip_addr
    retransmit_interval = new_resource.retransmit_interval
    message_digest_cfg = new_resource.message_digest_cfg
    out = new_resource.out

    params = { "ospf-ip": {"dead-interval": dead_interval,
        "authentication-key": authentication_key,
        "uuid": uuid,
        "mtu-ignore": mtu_ignore,
        "transmit-delay": transmit_delay,
        "value": value,
        "priority": priority,
        "authentication": authentication,
        "cost": cost,
        "database-filter": database_filter,
        "hello-interval": hello_interval,
        "ip-addr": ip_addr,
        "retransmit-interval": retransmit_interval,
        "message-digest-cfg": message_digest_cfg,
        "out": out,} }

    params[:"ospf-ip"].each do |k, v|
        if not v
            params[:"ospf-ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf-ip"].each do |k, v|
        if v != params[:"ospf-ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf-ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-ip/%<ip-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf-ip') do
            client.delete(url)
        end
    end
end