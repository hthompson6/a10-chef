resource_name :a10_router_ospf

property :a10_name, String, name_property: true
property :distribute_internal_list, Array
property :distribute_lists, Array
property :default_metric, Integer
property :auto_cost_reference_bandwidth, Integer
property :uuid, String
property :router_id, Hash
property :neighbor_list, Array
property :ospf_1, Hash
property :host_list, Array
property :log_adjacency_changes_cfg, Hash
property :area_list, Array
property :maximum_area, Integer
property :summary_address_list, Array
property :rfc1583_compatible, [true, false]
property :max_concurrent_dd, Integer
property :process_id, Integer,required: true
property :passive_interface, Hash
property :default_information, Hash
property :overflow, Hash
property :bfd_all_interfaces, [true, false]
property :distance, Hash
property :redistribute, Hash
property :user_tag, String
property :network_list, Array
property :timers, Hash
property :ha_standby_extra_cost, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ospf/"
    get_url = "/axapi/v3/router/ospf/%<process-id>s"
    distribute_internal_list = new_resource.distribute_internal_list
    distribute_lists = new_resource.distribute_lists
    default_metric = new_resource.default_metric
    auto_cost_reference_bandwidth = new_resource.auto_cost_reference_bandwidth
    uuid = new_resource.uuid
    router_id = new_resource.router_id
    neighbor_list = new_resource.neighbor_list
    ospf_1 = new_resource.ospf_1
    host_list = new_resource.host_list
    log_adjacency_changes_cfg = new_resource.log_adjacency_changes_cfg
    area_list = new_resource.area_list
    maximum_area = new_resource.maximum_area
    summary_address_list = new_resource.summary_address_list
    rfc1583_compatible = new_resource.rfc1583_compatible
    max_concurrent_dd = new_resource.max_concurrent_dd
    process_id = new_resource.process_id
    passive_interface = new_resource.passive_interface
    default_information = new_resource.default_information
    overflow = new_resource.overflow
    bfd_all_interfaces = new_resource.bfd_all_interfaces
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    user_tag = new_resource.user_tag
    network_list = new_resource.network_list
    timers = new_resource.timers
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost

    params = { "ospf": {"distribute-internal-list": distribute_internal_list,
        "distribute-lists": distribute_lists,
        "default-metric": default_metric,
        "auto-cost-reference-bandwidth": auto_cost_reference_bandwidth,
        "uuid": uuid,
        "router-id": router_id,
        "neighbor-list": neighbor_list,
        "ospf-1": ospf_1,
        "host-list": host_list,
        "log-adjacency-changes-cfg": log_adjacency_changes_cfg,
        "area-list": area_list,
        "maximum-area": maximum_area,
        "summary-address-list": summary_address_list,
        "rfc1583-compatible": rfc1583_compatible,
        "max-concurrent-dd": max_concurrent_dd,
        "process-id": process_id,
        "passive-interface": passive_interface,
        "default-information": default_information,
        "overflow": overflow,
        "bfd-all-interfaces": bfd_all_interfaces,
        "distance": distance,
        "redistribute": redistribute,
        "user-tag": user_tag,
        "network-list": network_list,
        "timers": timers,
        "ha-standby-extra-cost": ha_standby_extra_cost,} }

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
    url = "/axapi/v3/router/ospf/%<process-id>s"
    distribute_internal_list = new_resource.distribute_internal_list
    distribute_lists = new_resource.distribute_lists
    default_metric = new_resource.default_metric
    auto_cost_reference_bandwidth = new_resource.auto_cost_reference_bandwidth
    uuid = new_resource.uuid
    router_id = new_resource.router_id
    neighbor_list = new_resource.neighbor_list
    ospf_1 = new_resource.ospf_1
    host_list = new_resource.host_list
    log_adjacency_changes_cfg = new_resource.log_adjacency_changes_cfg
    area_list = new_resource.area_list
    maximum_area = new_resource.maximum_area
    summary_address_list = new_resource.summary_address_list
    rfc1583_compatible = new_resource.rfc1583_compatible
    max_concurrent_dd = new_resource.max_concurrent_dd
    process_id = new_resource.process_id
    passive_interface = new_resource.passive_interface
    default_information = new_resource.default_information
    overflow = new_resource.overflow
    bfd_all_interfaces = new_resource.bfd_all_interfaces
    distance = new_resource.distance
    redistribute = new_resource.redistribute
    user_tag = new_resource.user_tag
    network_list = new_resource.network_list
    timers = new_resource.timers
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost

    params = { "ospf": {"distribute-internal-list": distribute_internal_list,
        "distribute-lists": distribute_lists,
        "default-metric": default_metric,
        "auto-cost-reference-bandwidth": auto_cost_reference_bandwidth,
        "uuid": uuid,
        "router-id": router_id,
        "neighbor-list": neighbor_list,
        "ospf-1": ospf_1,
        "host-list": host_list,
        "log-adjacency-changes-cfg": log_adjacency_changes_cfg,
        "area-list": area_list,
        "maximum-area": maximum_area,
        "summary-address-list": summary_address_list,
        "rfc1583-compatible": rfc1583_compatible,
        "max-concurrent-dd": max_concurrent_dd,
        "process-id": process_id,
        "passive-interface": passive_interface,
        "default-information": default_information,
        "overflow": overflow,
        "bfd-all-interfaces": bfd_all_interfaces,
        "distance": distance,
        "redistribute": redistribute,
        "user-tag": user_tag,
        "network-list": network_list,
        "timers": timers,
        "ha-standby-extra-cost": ha_standby_extra_cost,} }

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
    url = "/axapi/v3/router/ospf/%<process-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end