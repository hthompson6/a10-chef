resource_name :a10_fw_tcp_rst_close_immediate

property :a10_name, String, name_property: true
property :status, ['enable','disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/tcp-rst-close-immediate"
    status = new_resource.status
    uuid = new_resource.uuid

    params = { "tcp-rst-close-immediate": {"status": status,
        "uuid": uuid,} }

    params[:"tcp-rst-close-immediate"].each do |k, v|
        if not v 
            params[:"tcp-rst-close-immediate"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp-rst-close-immediate') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/tcp-rst-close-immediate"
    status = new_resource.status
    uuid = new_resource.uuid

    params = { "tcp-rst-close-immediate": {"status": status,
        "uuid": uuid,} }

    params[:"tcp-rst-close-immediate"].each do |k, v|
        if not v
            params[:"tcp-rst-close-immediate"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp-rst-close-immediate"].each do |k, v|
        if v != params[:"tcp-rst-close-immediate"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp-rst-close-immediate') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/tcp-rst-close-immediate"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp-rst-close-immediate') do
            client.delete(url)
        end
    end
end