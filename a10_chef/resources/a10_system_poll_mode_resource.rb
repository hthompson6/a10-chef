resource_name :a10_system_poll_mode

property :a10_name, String, name_property: true
property :virtio, [true, false]
property :enable, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/system-poll-mode"
    virtio = new_resource.virtio
    enable = new_resource.enable

    params = { "system-poll-mode": {"virtio": virtio,
        "enable": enable,} }

    params[:"system-poll-mode"].each do |k, v|
        if not v 
            params[:"system-poll-mode"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-poll-mode') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-poll-mode"
    virtio = new_resource.virtio
    enable = new_resource.enable

    params = { "system-poll-mode": {"virtio": virtio,
        "enable": enable,} }

    params[:"system-poll-mode"].each do |k, v|
        if not v
            params[:"system-poll-mode"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-poll-mode"].each do |k, v|
        if v != params[:"system-poll-mode"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-poll-mode') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system-poll-mode"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-poll-mode') do
            client.delete(url)
        end
    end
end