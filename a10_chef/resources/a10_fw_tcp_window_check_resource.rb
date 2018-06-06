resource_name :a10_fw_tcp_window_check

property :a10_name, String, name_property: true
property :status, ['enable','disable']
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/tcp-window-check"
    status = new_resource.status
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "tcp-window-check": {"status": status,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"tcp-window-check"].each do |k, v|
        if not v 
            params[:"tcp-window-check"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp-window-check') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/tcp-window-check"
    status = new_resource.status
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "tcp-window-check": {"status": status,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"tcp-window-check"].each do |k, v|
        if not v
            params[:"tcp-window-check"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp-window-check"].each do |k, v|
        if v != params[:"tcp-window-check"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp-window-check') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/tcp-window-check"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp-window-check') do
            client.delete(url)
        end
    end
end