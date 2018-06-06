resource_name :a10_netflow_monitor_sample_nat_pool

property :a10_name, String, name_property: true
property :uuid, String
property :pool_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/%<name>s/sample/nat-pool/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s/sample/nat-pool/%<pool-name>s"
    uuid = new_resource.uuid
    pool_name = new_resource.pool_name

    params = { "nat-pool": {"uuid": uuid,
        "pool-name": pool_name,} }

    params[:"nat-pool"].each do |k, v|
        if not v 
            params[:"nat-pool"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nat-pool') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/sample/nat-pool/%<pool-name>s"
    uuid = new_resource.uuid
    pool_name = new_resource.pool_name

    params = { "nat-pool": {"uuid": uuid,
        "pool-name": pool_name,} }

    params[:"nat-pool"].each do |k, v|
        if not v
            params[:"nat-pool"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nat-pool"].each do |k, v|
        if v != params[:"nat-pool"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nat-pool') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/sample/nat-pool/%<pool-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nat-pool') do
            client.delete(url)
        end
    end
end