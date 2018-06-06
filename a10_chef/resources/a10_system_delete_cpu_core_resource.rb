resource_name :a10_system_delete_cpu_core

property :a10_name, String, name_property: true
property :core_index, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/delete-cpu-core"
    core_index = new_resource.core_index

    params = { "delete-cpu-core": {"core-index": core_index,} }

    params[:"delete-cpu-core"].each do |k, v|
        if not v 
            params[:"delete-cpu-core"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating delete-cpu-core') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/delete-cpu-core"
    core_index = new_resource.core_index

    params = { "delete-cpu-core": {"core-index": core_index,} }

    params[:"delete-cpu-core"].each do |k, v|
        if not v
            params[:"delete-cpu-core"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["delete-cpu-core"].each do |k, v|
        if v != params[:"delete-cpu-core"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating delete-cpu-core') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/delete-cpu-core"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting delete-cpu-core') do
            client.delete(url)
        end
    end
end