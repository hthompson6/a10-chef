resource_name :a10_allow_slb_cfg

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/allow-slb-cfg"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "allow-slb-cfg": {"enable": enable,
        "uuid": uuid,} }

    params[:"allow-slb-cfg"].each do |k, v|
        if not v 
            params[:"allow-slb-cfg"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating allow-slb-cfg') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/allow-slb-cfg"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "allow-slb-cfg": {"enable": enable,
        "uuid": uuid,} }

    params[:"allow-slb-cfg"].each do |k, v|
        if not v
            params[:"allow-slb-cfg"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["allow-slb-cfg"].each do |k, v|
        if v != params[:"allow-slb-cfg"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating allow-slb-cfg') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/allow-slb-cfg"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting allow-slb-cfg') do
            client.delete(url)
        end
    end
end