resource_name :a10_system_cpu_load_sharing

property :a10_name, String, name_property: true
property :packets_per_second, Hash
property :cpu_usage, Hash
property :disable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/cpu-load-sharing"
    packets_per_second = new_resource.packets_per_second
    cpu_usage = new_resource.cpu_usage
    disable = new_resource.disable
    uuid = new_resource.uuid

    params = { "cpu-load-sharing": {"packets-per-second": packets_per_second,
        "cpu-usage": cpu_usage,
        "disable": disable,
        "uuid": uuid,} }

    params[:"cpu-load-sharing"].each do |k, v|
        if not v 
            params[:"cpu-load-sharing"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cpu-load-sharing') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cpu-load-sharing"
    packets_per_second = new_resource.packets_per_second
    cpu_usage = new_resource.cpu_usage
    disable = new_resource.disable
    uuid = new_resource.uuid

    params = { "cpu-load-sharing": {"packets-per-second": packets_per_second,
        "cpu-usage": cpu_usage,
        "disable": disable,
        "uuid": uuid,} }

    params[:"cpu-load-sharing"].each do |k, v|
        if not v
            params[:"cpu-load-sharing"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cpu-load-sharing"].each do |k, v|
        if v != params[:"cpu-load-sharing"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cpu-load-sharing') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cpu-load-sharing"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cpu-load-sharing') do
            client.delete(url)
        end
    end
end