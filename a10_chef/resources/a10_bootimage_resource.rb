resource_name :a10_bootimage

property :a10_name, String, name_property: true
property :hd_cfg, Hash
property :cf_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/bootimage"
    hd_cfg = new_resource.hd_cfg
    cf_cfg = new_resource.cf_cfg

    params = { "bootimage": {"hd-cfg": hd_cfg,
        "cf-cfg": cf_cfg,} }

    params[:"bootimage"].each do |k, v|
        if not v 
            params[:"bootimage"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bootimage') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/bootimage"
    hd_cfg = new_resource.hd_cfg
    cf_cfg = new_resource.cf_cfg

    params = { "bootimage": {"hd-cfg": hd_cfg,
        "cf-cfg": cf_cfg,} }

    params[:"bootimage"].each do |k, v|
        if not v
            params[:"bootimage"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bootimage"].each do |k, v|
        if v != params[:"bootimage"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bootimage') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/bootimage"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bootimage') do
            client.delete(url)
        end
    end
end