resource_name :a10_interface_ve_ip_ospf_ospf_global

property :a10_name, String, name_property: true
property :cost, Integer
property :dead_interval, Integer
property :authentication_key, String
property :network, Hash
property :mtu_ignore, [true, false]
property :transmit_delay, Integer
property :authentication_cfg, Hash
property :retransmit_interval, Integer
property :bfd_cfg, Hash
property :disable, ['all']
property :hello_interval, Integer
property :database_filter_cfg, Hash
property :priority, Integer
property :mtu, Integer
property :message_digest_cfg, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/"
    get_url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-global"
    cost = new_resource.cost
    dead_interval = new_resource.dead_interval
    authentication_key = new_resource.authentication_key
    network = new_resource.network
    mtu_ignore = new_resource.mtu_ignore
    transmit_delay = new_resource.transmit_delay
    authentication_cfg = new_resource.authentication_cfg
    retransmit_interval = new_resource.retransmit_interval
    bfd_cfg = new_resource.bfd_cfg
    disable = new_resource.disable
    hello_interval = new_resource.hello_interval
    database_filter_cfg = new_resource.database_filter_cfg
    priority = new_resource.priority
    mtu = new_resource.mtu
    message_digest_cfg = new_resource.message_digest_cfg
    uuid = new_resource.uuid

    params = { "ospf-global": {"cost": cost,
        "dead-interval": dead_interval,
        "authentication-key": authentication_key,
        "network": network,
        "mtu-ignore": mtu_ignore,
        "transmit-delay": transmit_delay,
        "authentication-cfg": authentication_cfg,
        "retransmit-interval": retransmit_interval,
        "bfd-cfg": bfd_cfg,
        "disable": disable,
        "hello-interval": hello_interval,
        "database-filter-cfg": database_filter_cfg,
        "priority": priority,
        "mtu": mtu,
        "message-digest-cfg": message_digest_cfg,
        "uuid": uuid,} }

    params[:"ospf-global"].each do |k, v|
        if not v 
            params[:"ospf-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-global"
    cost = new_resource.cost
    dead_interval = new_resource.dead_interval
    authentication_key = new_resource.authentication_key
    network = new_resource.network
    mtu_ignore = new_resource.mtu_ignore
    transmit_delay = new_resource.transmit_delay
    authentication_cfg = new_resource.authentication_cfg
    retransmit_interval = new_resource.retransmit_interval
    bfd_cfg = new_resource.bfd_cfg
    disable = new_resource.disable
    hello_interval = new_resource.hello_interval
    database_filter_cfg = new_resource.database_filter_cfg
    priority = new_resource.priority
    mtu = new_resource.mtu
    message_digest_cfg = new_resource.message_digest_cfg
    uuid = new_resource.uuid

    params = { "ospf-global": {"cost": cost,
        "dead-interval": dead_interval,
        "authentication-key": authentication_key,
        "network": network,
        "mtu-ignore": mtu_ignore,
        "transmit-delay": transmit_delay,
        "authentication-cfg": authentication_cfg,
        "retransmit-interval": retransmit_interval,
        "bfd-cfg": bfd_cfg,
        "disable": disable,
        "hello-interval": hello_interval,
        "database-filter-cfg": database_filter_cfg,
        "priority": priority,
        "mtu": mtu,
        "message-digest-cfg": message_digest_cfg,
        "uuid": uuid,} }

    params[:"ospf-global"].each do |k, v|
        if not v
            params[:"ospf-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf-global"].each do |k, v|
        if v != params[:"ospf-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ve/%<ifnum>s/ip/ospf/ospf-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf-global') do
            client.delete(url)
        end
    end
end