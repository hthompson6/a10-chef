resource_name :a10_slb_virtual_server_migrate_vip

property :a10_name, String, name_property: true
property :cancel_migration, [true, false]
property :target_data_cpu, Integer
property :target_floating_ipv6, String
property :finish_migration, [true, false]
property :target_floating_ipv4, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/virtual-server/%<name>s/"
    get_url = "/axapi/v3/slb/virtual-server/%<name>s/migrate-vip"
    cancel_migration = new_resource.cancel_migration
    target_data_cpu = new_resource.target_data_cpu
    target_floating_ipv6 = new_resource.target_floating_ipv6
    finish_migration = new_resource.finish_migration
    target_floating_ipv4 = new_resource.target_floating_ipv4

    params = { "migrate-vip": {"cancel-migration": cancel_migration,
        "target-data-cpu": target_data_cpu,
        "target-floating-ipv6": target_floating_ipv6,
        "finish-migration": finish_migration,
        "target-floating-ipv4": target_floating_ipv4,} }

    params[:"migrate-vip"].each do |k, v|
        if not v 
            params[:"migrate-vip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating migrate-vip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/migrate-vip"
    cancel_migration = new_resource.cancel_migration
    target_data_cpu = new_resource.target_data_cpu
    target_floating_ipv6 = new_resource.target_floating_ipv6
    finish_migration = new_resource.finish_migration
    target_floating_ipv4 = new_resource.target_floating_ipv4

    params = { "migrate-vip": {"cancel-migration": cancel_migration,
        "target-data-cpu": target_data_cpu,
        "target-floating-ipv6": target_floating_ipv6,
        "finish-migration": finish_migration,
        "target-floating-ipv4": target_floating_ipv4,} }

    params[:"migrate-vip"].each do |k, v|
        if not v
            params[:"migrate-vip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["migrate-vip"].each do |k, v|
        if v != params[:"migrate-vip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating migrate-vip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/migrate-vip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting migrate-vip') do
            client.delete(url)
        end
    end
end