resource_name :a10_system_cpu_hyper_thread

property :a10_name, String, name_property: true
property :enable, [true, false]
property :disable, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/cpu-hyper-thread"
    enable = new_resource.enable
    disable = new_resource.disable

    params = { "cpu-hyper-thread": {"enable": enable,
        "disable": disable,} }

    params[:"cpu-hyper-thread"].each do |k, v|
        if not v 
            params[:"cpu-hyper-thread"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cpu-hyper-thread') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cpu-hyper-thread"
    enable = new_resource.enable
    disable = new_resource.disable

    params = { "cpu-hyper-thread": {"enable": enable,
        "disable": disable,} }

    params[:"cpu-hyper-thread"].each do |k, v|
        if not v
            params[:"cpu-hyper-thread"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cpu-hyper-thread"].each do |k, v|
        if v != params[:"cpu-hyper-thread"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cpu-hyper-thread') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cpu-hyper-thread"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cpu-hyper-thread') do
            client.delete(url)
        end
    end
end