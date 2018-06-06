resource_name :a10_router_ipv6_ospf

property :a10_name, String, name_property: true
property :timers, Hash
property :redistribute, Hash
property :abr_type_option, ['cisco','ibm','standard']
property :auto_cost_reference_bandwidth, Integer
property :router_id, String
property :distribute_internal_list, Array
property :default_metric, Integer
property :user_tag, String
property :max_concurrent_dd, Integer
property :process_id, String,required: true
property :log_adjacency_changes, ['detail','disable']
property :passive_interface, Hash
property :default_information, Hash
property :ha_standby_extra_cost, Array
property :uuid, String
property :bfd_all_interfaces, [true, false]
property :area_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ipv6/ospf/"
    get_url = "/axapi/v3/router/ipv6/ospf/%<process-id>s"
    timers = new_resource.timers
    redistribute = new_resource.redistribute
    abr_type_option = new_resource.abr_type_option
    auto_cost_reference_bandwidth = new_resource.auto_cost_reference_bandwidth
    router_id = new_resource.router_id
    distribute_internal_list = new_resource.distribute_internal_list
    default_metric = new_resource.default_metric
    user_tag = new_resource.user_tag
    max_concurrent_dd = new_resource.max_concurrent_dd
    process_id = new_resource.process_id
    log_adjacency_changes = new_resource.log_adjacency_changes
    passive_interface = new_resource.passive_interface
    default_information = new_resource.default_information
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost
    uuid = new_resource.uuid
    bfd_all_interfaces = new_resource.bfd_all_interfaces
    area_list = new_resource.area_list

    params = { "ospf": {"timers": timers,
        "redistribute": redistribute,
        "abr-type-option": abr_type_option,
        "auto-cost-reference-bandwidth": auto_cost_reference_bandwidth,
        "router-id": router_id,
        "distribute-internal-list": distribute_internal_list,
        "default-metric": default_metric,
        "user-tag": user_tag,
        "max-concurrent-dd": max_concurrent_dd,
        "process-id": process_id,
        "log-adjacency-changes": log_adjacency_changes,
        "passive-interface": passive_interface,
        "default-information": default_information,
        "ha-standby-extra-cost": ha_standby_extra_cost,
        "uuid": uuid,
        "bfd-all-interfaces": bfd_all_interfaces,
        "area-list": area_list,} }

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
    url = "/axapi/v3/router/ipv6/ospf/%<process-id>s"
    timers = new_resource.timers
    redistribute = new_resource.redistribute
    abr_type_option = new_resource.abr_type_option
    auto_cost_reference_bandwidth = new_resource.auto_cost_reference_bandwidth
    router_id = new_resource.router_id
    distribute_internal_list = new_resource.distribute_internal_list
    default_metric = new_resource.default_metric
    user_tag = new_resource.user_tag
    max_concurrent_dd = new_resource.max_concurrent_dd
    process_id = new_resource.process_id
    log_adjacency_changes = new_resource.log_adjacency_changes
    passive_interface = new_resource.passive_interface
    default_information = new_resource.default_information
    ha_standby_extra_cost = new_resource.ha_standby_extra_cost
    uuid = new_resource.uuid
    bfd_all_interfaces = new_resource.bfd_all_interfaces
    area_list = new_resource.area_list

    params = { "ospf": {"timers": timers,
        "redistribute": redistribute,
        "abr-type-option": abr_type_option,
        "auto-cost-reference-bandwidth": auto_cost_reference_bandwidth,
        "router-id": router_id,
        "distribute-internal-list": distribute_internal_list,
        "default-metric": default_metric,
        "user-tag": user_tag,
        "max-concurrent-dd": max_concurrent_dd,
        "process-id": process_id,
        "log-adjacency-changes": log_adjacency_changes,
        "passive-interface": passive_interface,
        "default-information": default_information,
        "ha-standby-extra-cost": ha_standby_extra_cost,
        "uuid": uuid,
        "bfd-all-interfaces": bfd_all_interfaces,
        "area-list": area_list,} }

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
    url = "/axapi/v3/router/ipv6/ospf/%<process-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end