resource_name :a10_system_ipmi_service

property :a10_name, String, name_property: true
property :disable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/ipmi-service"
    disable = new_resource.disable
    uuid = new_resource.uuid

    params = { "ipmi-service": {"disable": disable,
        "uuid": uuid,} }

    params[:"ipmi-service"].each do |k, v|
        if not v 
            params[:"ipmi-service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipmi-service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi-service"
    disable = new_resource.disable
    uuid = new_resource.uuid

    params = { "ipmi-service": {"disable": disable,
        "uuid": uuid,} }

    params[:"ipmi-service"].each do |k, v|
        if not v
            params[:"ipmi-service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipmi-service"].each do |k, v|
        if v != params[:"ipmi-service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipmi-service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi-service"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipmi-service') do
            client.delete(url)
        end
    end
end