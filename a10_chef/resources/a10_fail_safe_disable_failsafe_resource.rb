resource_name :a10_fail_safe_disable_failsafe

property :a10_name, String, name_property: true
property :a10_action, ['all','io-buffer','session-memory','system-memory']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fail-safe/"
    get_url = "/axapi/v3/fail-safe/disable-failsafe"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "disable-failsafe": {"action": a10_action,
        "uuid": uuid,} }

    params[:"disable-failsafe"].each do |k, v|
        if not v 
            params[:"disable-failsafe"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating disable-failsafe') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fail-safe/disable-failsafe"
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "disable-failsafe": {"action": a10_action,
        "uuid": uuid,} }

    params[:"disable-failsafe"].each do |k, v|
        if not v
            params[:"disable-failsafe"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["disable-failsafe"].each do |k, v|
        if v != params[:"disable-failsafe"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating disable-failsafe') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fail-safe/disable-failsafe"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting disable-failsafe') do
            client.delete(url)
        end
    end
end