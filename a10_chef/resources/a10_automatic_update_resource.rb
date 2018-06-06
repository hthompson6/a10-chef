resource_name :a10_automatic_update

property :a10_name, String, name_property: true
property :info, Hash
property :reset, Hash
property :uuid, String
property :use_mgmt_port, [true, false]
property :checknow, Hash
property :revert, Hash
property :proxy_server, Hash
property :check_now, Hash
property :config_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/automatic-update"
    info = new_resource.info
    reset = new_resource.reset
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    checknow = new_resource.checknow
    revert = new_resource.revert
    proxy_server = new_resource.proxy_server
    check_now = new_resource.check_now
    config_list = new_resource.config_list

    params = { "automatic-update": {"info": info,
        "reset": reset,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "checknow": checknow,
        "revert": revert,
        "proxy-server": proxy_server,
        "check-now": check_now,
        "config-list": config_list,} }

    params[:"automatic-update"].each do |k, v|
        if not v 
            params[:"automatic-update"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating automatic-update') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update"
    info = new_resource.info
    reset = new_resource.reset
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    checknow = new_resource.checknow
    revert = new_resource.revert
    proxy_server = new_resource.proxy_server
    check_now = new_resource.check_now
    config_list = new_resource.config_list

    params = { "automatic-update": {"info": info,
        "reset": reset,
        "uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "checknow": checknow,
        "revert": revert,
        "proxy-server": proxy_server,
        "check-now": check_now,
        "config-list": config_list,} }

    params[:"automatic-update"].each do |k, v|
        if not v
            params[:"automatic-update"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["automatic-update"].each do |k, v|
        if v != params[:"automatic-update"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating automatic-update') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/automatic-update"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting automatic-update') do
            client.delete(url)
        end
    end
end