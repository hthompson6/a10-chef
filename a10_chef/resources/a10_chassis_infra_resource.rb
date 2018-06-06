resource_name :a10_chassis_infra

property :a10_name, String, name_property: true
property :detailed, [true, false]
property :debug_status, [true, false]
property :debug_disable, [true, false]
property :debug_enable, [true, false]
property :system_sync_verify, [true, false]
property :sys_sync, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/chassis-infra"
    detailed = new_resource.detailed
    debug_status = new_resource.debug_status
    debug_disable = new_resource.debug_disable
    debug_enable = new_resource.debug_enable
    system_sync_verify = new_resource.system_sync_verify
    sys_sync = new_resource.sys_sync

    params = { "chassis-infra": {"detailed": detailed,
        "debug-status": debug_status,
        "debug-disable": debug_disable,
        "debug-enable": debug_enable,
        "system-sync-verify": system_sync_verify,
        "sys-sync": sys_sync,} }

    params[:"chassis-infra"].each do |k, v|
        if not v 
            params[:"chassis-infra"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating chassis-infra') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/chassis-infra"
    detailed = new_resource.detailed
    debug_status = new_resource.debug_status
    debug_disable = new_resource.debug_disable
    debug_enable = new_resource.debug_enable
    system_sync_verify = new_resource.system_sync_verify
    sys_sync = new_resource.sys_sync

    params = { "chassis-infra": {"detailed": detailed,
        "debug-status": debug_status,
        "debug-disable": debug_disable,
        "debug-enable": debug_enable,
        "system-sync-verify": system_sync_verify,
        "sys-sync": sys_sync,} }

    params[:"chassis-infra"].each do |k, v|
        if not v
            params[:"chassis-infra"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["chassis-infra"].each do |k, v|
        if v != params[:"chassis-infra"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating chassis-infra') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/chassis-infra"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting chassis-infra') do
            client.delete(url)
        end
    end
end