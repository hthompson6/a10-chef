resource_name :a10_gslb_policy_connection_load

property :a10_name, String, name_property: true
property :uuid, String
property :connection_load_enable, [true, false]
property :connection_load_interval, Integer
property :limit, [true, false]
property :connection_load_samples, Integer
property :connection_load_limit, Integer
property :connection_load_fail_break, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/connection-load"
    uuid = new_resource.uuid
    connection_load_enable = new_resource.connection_load_enable
    connection_load_interval = new_resource.connection_load_interval
    limit = new_resource.limit
    connection_load_samples = new_resource.connection_load_samples
    connection_load_limit = new_resource.connection_load_limit
    connection_load_fail_break = new_resource.connection_load_fail_break

    params = { "connection-load": {"uuid": uuid,
        "connection-load-enable": connection_load_enable,
        "connection-load-interval": connection_load_interval,
        "limit": limit,
        "connection-load-samples": connection_load_samples,
        "connection-load-limit": connection_load_limit,
        "connection-load-fail-break": connection_load_fail_break,} }

    params[:"connection-load"].each do |k, v|
        if not v 
            params[:"connection-load"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating connection-load') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/connection-load"
    uuid = new_resource.uuid
    connection_load_enable = new_resource.connection_load_enable
    connection_load_interval = new_resource.connection_load_interval
    limit = new_resource.limit
    connection_load_samples = new_resource.connection_load_samples
    connection_load_limit = new_resource.connection_load_limit
    connection_load_fail_break = new_resource.connection_load_fail_break

    params = { "connection-load": {"uuid": uuid,
        "connection-load-enable": connection_load_enable,
        "connection-load-interval": connection_load_interval,
        "limit": limit,
        "connection-load-samples": connection_load_samples,
        "connection-load-limit": connection_load_limit,
        "connection-load-fail-break": connection_load_fail_break,} }

    params[:"connection-load"].each do |k, v|
        if not v
            params[:"connection-load"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["connection-load"].each do |k, v|
        if v != params[:"connection-load"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating connection-load') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/connection-load"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting connection-load') do
            client.delete(url)
        end
    end
end