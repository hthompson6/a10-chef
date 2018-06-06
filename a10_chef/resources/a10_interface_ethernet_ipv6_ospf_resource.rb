resource_name :a10_interface_ethernet_ipv6_ospf

property :a10_name, String, name_property: true
property :uuid, String
property :bfd, [true, false]
property :cost_cfg, Array
property :priority_cfg, Array
property :hello_interval_cfg, Array
property :mtu_ignore_cfg, Array
property :retransmit_interval_cfg, Array
property :disable, [true, false]
property :transmit_delay_cfg, Array
property :neighbor_cfg, Array
property :network_list, Array
property :dead_interval_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/%<ifnum>s/ipv6/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s/ipv6/ospf"
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    cost_cfg = new_resource.cost_cfg
    priority_cfg = new_resource.priority_cfg
    hello_interval_cfg = new_resource.hello_interval_cfg
    mtu_ignore_cfg = new_resource.mtu_ignore_cfg
    retransmit_interval_cfg = new_resource.retransmit_interval_cfg
    disable = new_resource.disable
    transmit_delay_cfg = new_resource.transmit_delay_cfg
    neighbor_cfg = new_resource.neighbor_cfg
    network_list = new_resource.network_list
    dead_interval_cfg = new_resource.dead_interval_cfg

    params = { "ospf": {"uuid": uuid,
        "bfd": bfd,
        "cost-cfg": cost_cfg,
        "priority-cfg": priority_cfg,
        "hello-interval-cfg": hello_interval_cfg,
        "mtu-ignore-cfg": mtu_ignore_cfg,
        "retransmit-interval-cfg": retransmit_interval_cfg,
        "disable": disable,
        "transmit-delay-cfg": transmit_delay_cfg,
        "neighbor-cfg": neighbor_cfg,
        "network-list": network_list,
        "dead-interval-cfg": dead_interval_cfg,} }

    params[:"ospf"].each do |k, v|
        if not v 
            params[:"ospf"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/ipv6/ospf"
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    cost_cfg = new_resource.cost_cfg
    priority_cfg = new_resource.priority_cfg
    hello_interval_cfg = new_resource.hello_interval_cfg
    mtu_ignore_cfg = new_resource.mtu_ignore_cfg
    retransmit_interval_cfg = new_resource.retransmit_interval_cfg
    disable = new_resource.disable
    transmit_delay_cfg = new_resource.transmit_delay_cfg
    neighbor_cfg = new_resource.neighbor_cfg
    network_list = new_resource.network_list
    dead_interval_cfg = new_resource.dead_interval_cfg

    params = { "ospf": {"uuid": uuid,
        "bfd": bfd,
        "cost-cfg": cost_cfg,
        "priority-cfg": priority_cfg,
        "hello-interval-cfg": hello_interval_cfg,
        "mtu-ignore-cfg": mtu_ignore_cfg,
        "retransmit-interval-cfg": retransmit_interval_cfg,
        "disable": disable,
        "transmit-delay-cfg": transmit_delay_cfg,
        "neighbor-cfg": neighbor_cfg,
        "network-list": network_list,
        "dead-interval-cfg": dead_interval_cfg,} }

    params[:"ospf"].each do |k, v|
        if not v
            params[:"ospf"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf"].each do |k, v|
        if v != params[:"ospf"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/ipv6/ospf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end