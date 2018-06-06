resource_name :a10_system_reset

property :a10_name, String, name_property: true
property :reboot_flag, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-reset"
    reboot_flag = new_resource.reboot_flag

    params = { "system-reset": {"reboot-flag": reboot_flag,} }

    params[:"system-reset"].each do |k, v|
        if not v 
            params[:"system-reset"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-reset') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-reset"
    reboot_flag = new_resource.reboot_flag

    params = { "system-reset": {"reboot-flag": reboot_flag,} }

    params[:"system-reset"].each do |k, v|
        if not v
            params[:"system-reset"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-reset"].each do |k, v|
        if v != params[:"system-reset"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-reset') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-reset"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-reset') do
            client.delete(url)
        end
    end
end