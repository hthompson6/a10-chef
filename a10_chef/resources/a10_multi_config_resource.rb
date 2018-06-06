resource_name :a10_multi_config

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/multi-config"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "multi-config": {"enable": enable,
        "uuid": uuid,} }

    params[:"multi-config"].each do |k, v|
        if not v 
            params[:"multi-config"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating multi-config') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/multi-config"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "multi-config": {"enable": enable,
        "uuid": uuid,} }

    params[:"multi-config"].each do |k, v|
        if not v
            params[:"multi-config"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["multi-config"].each do |k, v|
        if v != params[:"multi-config"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating multi-config') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/multi-config"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting multi-config') do
            client.delete(url)
        end
    end
end