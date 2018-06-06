resource_name :a10_cgnv6_nat_pool

property :a10_name, String, name_property: true
property :all, [true, false]
property :tcp_time_wait_interval, Integer
property :group, String
property :uuid, String
property :start_address, String
property :per_batch_port_usage_warning_threshold, Integer
property :vrid, Integer
property :usable_nat_ports_start, Integer
property :usable_nat_ports_end, Integer
property :partition, String
property :netmask, String
property :max_users_per_ip, Integer
property :simultaneous_batch_allocation, [true, false]
property :shared, [true, false]
property :port_batch_v2_size, ['64','128','256','512','1024','2048','4096']
property :end_address, String
property :usable_nat_ports, [true, false]
property :exclude_ip, Array
property :pool_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat/pool/"
    get_url = "/axapi/v3/cgnv6/nat/pool/%<pool-name>s"
    all = new_resource.all
    tcp_time_wait_interval = new_resource.tcp_time_wait_interval
    group = new_resource.group
    uuid = new_resource.uuid
    start_address = new_resource.start_address
    per_batch_port_usage_warning_threshold = new_resource.per_batch_port_usage_warning_threshold
    vrid = new_resource.vrid
    usable_nat_ports_start = new_resource.usable_nat_ports_start
    usable_nat_ports_end = new_resource.usable_nat_ports_end
    partition = new_resource.partition
    netmask = new_resource.netmask
    max_users_per_ip = new_resource.max_users_per_ip
    simultaneous_batch_allocation = new_resource.simultaneous_batch_allocation
    shared = new_resource.shared
    port_batch_v2_size = new_resource.port_batch_v2_size
    end_address = new_resource.end_address
    usable_nat_ports = new_resource.usable_nat_ports
    exclude_ip = new_resource.exclude_ip
    pool_name = new_resource.pool_name

    params = { "pool": {"all": all,
        "tcp-time-wait-interval": tcp_time_wait_interval,
        "group": group,
        "uuid": uuid,
        "start-address": start_address,
        "per-batch-port-usage-warning-threshold": per_batch_port_usage_warning_threshold,
        "vrid": vrid,
        "usable-nat-ports-start": usable_nat_ports_start,
        "usable-nat-ports-end": usable_nat_ports_end,
        "partition": partition,
        "netmask": netmask,
        "max-users-per-ip": max_users_per_ip,
        "simultaneous-batch-allocation": simultaneous_batch_allocation,
        "shared": shared,
        "port-batch-v2-size": port_batch_v2_size,
        "end-address": end_address,
        "usable-nat-ports": usable_nat_ports,
        "exclude-ip": exclude_ip,
        "pool-name": pool_name,} }

    params[:"pool"].each do |k, v|
        if not v 
            params[:"pool"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pool') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/pool/%<pool-name>s"
    all = new_resource.all
    tcp_time_wait_interval = new_resource.tcp_time_wait_interval
    group = new_resource.group
    uuid = new_resource.uuid
    start_address = new_resource.start_address
    per_batch_port_usage_warning_threshold = new_resource.per_batch_port_usage_warning_threshold
    vrid = new_resource.vrid
    usable_nat_ports_start = new_resource.usable_nat_ports_start
    usable_nat_ports_end = new_resource.usable_nat_ports_end
    partition = new_resource.partition
    netmask = new_resource.netmask
    max_users_per_ip = new_resource.max_users_per_ip
    simultaneous_batch_allocation = new_resource.simultaneous_batch_allocation
    shared = new_resource.shared
    port_batch_v2_size = new_resource.port_batch_v2_size
    end_address = new_resource.end_address
    usable_nat_ports = new_resource.usable_nat_ports
    exclude_ip = new_resource.exclude_ip
    pool_name = new_resource.pool_name

    params = { "pool": {"all": all,
        "tcp-time-wait-interval": tcp_time_wait_interval,
        "group": group,
        "uuid": uuid,
        "start-address": start_address,
        "per-batch-port-usage-warning-threshold": per_batch_port_usage_warning_threshold,
        "vrid": vrid,
        "usable-nat-ports-start": usable_nat_ports_start,
        "usable-nat-ports-end": usable_nat_ports_end,
        "partition": partition,
        "netmask": netmask,
        "max-users-per-ip": max_users_per_ip,
        "simultaneous-batch-allocation": simultaneous_batch_allocation,
        "shared": shared,
        "port-batch-v2-size": port_batch_v2_size,
        "end-address": end_address,
        "usable-nat-ports": usable_nat_ports,
        "exclude-ip": exclude_ip,
        "pool-name": pool_name,} }

    params[:"pool"].each do |k, v|
        if not v
            params[:"pool"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pool"].each do |k, v|
        if v != params[:"pool"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pool') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/pool/%<pool-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pool') do
            client.delete(url)
        end
    end
end