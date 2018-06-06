resource_name :a10_netflow_collector

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']
property :sampling_enable, Array
property :uuid, String
property :active_timeout, Integer
property :template, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/"
    get_url = "/axapi/v3/netflow/collector"
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    active_timeout = new_resource.active_timeout
    template = new_resource.template

    params = { "collector": {"action": a10_action,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "active-timeout": active_timeout,
        "template": template,} }

    params[:"collector"].each do |k, v|
        if not v 
            params[:"collector"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating collector') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/collector"
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid
    active_timeout = new_resource.active_timeout
    template = new_resource.template

    params = { "collector": {"action": a10_action,
        "sampling-enable": sampling_enable,
        "uuid": uuid,
        "active-timeout": active_timeout,
        "template": template,} }

    params[:"collector"].each do |k, v|
        if not v
            params[:"collector"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["collector"].each do |k, v|
        if v != params[:"collector"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating collector') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/collector"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting collector') do
            client.delete(url)
        end
    end
end