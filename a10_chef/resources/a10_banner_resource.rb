resource_name :a10_banner

property :a10_name, String, name_property: true
property :exec_banner_cfg, Hash
property :uuid, String
property :login_banner_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/banner"
    exec_banner_cfg = new_resource.exec_banner_cfg
    uuid = new_resource.uuid
    login_banner_cfg = new_resource.login_banner_cfg

    params = { "banner": {"exec-banner-cfg": exec_banner_cfg,
        "uuid": uuid,
        "login-banner-cfg": login_banner_cfg,} }

    params[:"banner"].each do |k, v|
        if not v 
            params[:"banner"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating banner') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/banner"
    exec_banner_cfg = new_resource.exec_banner_cfg
    uuid = new_resource.uuid
    login_banner_cfg = new_resource.login_banner_cfg

    params = { "banner": {"exec-banner-cfg": exec_banner_cfg,
        "uuid": uuid,
        "login-banner-cfg": login_banner_cfg,} }

    params[:"banner"].each do |k, v|
        if not v
            params[:"banner"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["banner"].each do |k, v|
        if v != params[:"banner"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating banner') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/banner"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting banner') do
            client.delete(url)
        end
    end
end