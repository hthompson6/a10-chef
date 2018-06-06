resource_name :a10_file_inspection_service

property :a10_name, String, name_property: true
property :health_check_disable, [true, false]
property :enable, [true, false]
property :uuid, String
property :service_down_action, ['reset','allow']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file-inspection/"
    get_url = "/axapi/v3/file-inspection/service"
    health_check_disable = new_resource.health_check_disable
    enable = new_resource.enable
    uuid = new_resource.uuid
    service_down_action = new_resource.service_down_action

    params = { "service": {"health-check-disable": health_check_disable,
        "enable": enable,
        "uuid": uuid,
        "service-down-action": service_down_action,} }

    params[:"service"].each do |k, v|
        if not v 
            params[:"service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/service"
    health_check_disable = new_resource.health_check_disable
    enable = new_resource.enable
    uuid = new_resource.uuid
    service_down_action = new_resource.service_down_action

    params = { "service": {"health-check-disable": health_check_disable,
        "enable": enable,
        "uuid": uuid,
        "service-down-action": service_down_action,} }

    params[:"service"].each do |k, v|
        if not v
            params[:"service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service"].each do |k, v|
        if v != params[:"service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/service"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service') do
            client.delete(url)
        end
    end
end