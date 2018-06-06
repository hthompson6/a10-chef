resource_name :a10_system_4x10g_mode

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-4x10g-mode"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "system-4x10g-mode": {"enable": enable,
        "uuid": uuid,} }

    params[:"system-4x10g-mode"].each do |k, v|
        if not v 
            params[:"system-4x10g-mode"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-4x10g-mode') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-4x10g-mode"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "system-4x10g-mode": {"enable": enable,
        "uuid": uuid,} }

    params[:"system-4x10g-mode"].each do |k, v|
        if not v
            params[:"system-4x10g-mode"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-4x10g-mode"].each do |k, v|
        if v != params[:"system-4x10g-mode"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-4x10g-mode') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-4x10g-mode"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-4x10g-mode') do
            client.delete(url)
        end
    end
end