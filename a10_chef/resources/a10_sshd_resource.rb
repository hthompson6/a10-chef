resource_name :a10_sshd

property :a10_name, String, name_property: true
property :load, [true, false]
property :use_mgmt_port, [true, false]
property :regenerate, [true, false]
property :wipe, [true, false]
property :restart, [true, false]
property :generate, [true, false]
property :file_url, String
property :size, ['2048','4096']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/sshd"
    load = new_resource.load
    use_mgmt_port = new_resource.use_mgmt_port
    regenerate = new_resource.regenerate
    wipe = new_resource.wipe
    restart = new_resource.restart
    generate = new_resource.generate
    file_url = new_resource.file_url
    size = new_resource.size

    params = { "sshd": {"load": load,
        "use-mgmt-port": use_mgmt_port,
        "regenerate": regenerate,
        "wipe": wipe,
        "restart": restart,
        "generate": generate,
        "file-url": file_url,
        "size": size,} }

    params[:"sshd"].each do |k, v|
        if not v 
            params[:"sshd"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sshd') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sshd"
    load = new_resource.load
    use_mgmt_port = new_resource.use_mgmt_port
    regenerate = new_resource.regenerate
    wipe = new_resource.wipe
    restart = new_resource.restart
    generate = new_resource.generate
    file_url = new_resource.file_url
    size = new_resource.size

    params = { "sshd": {"load": load,
        "use-mgmt-port": use_mgmt_port,
        "regenerate": regenerate,
        "wipe": wipe,
        "restart": restart,
        "generate": generate,
        "file-url": file_url,
        "size": size,} }

    params[:"sshd"].each do |k, v|
        if not v
            params[:"sshd"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sshd"].each do |k, v|
        if v != params[:"sshd"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sshd') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sshd"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sshd') do
            client.delete(url)
        end
    end
end