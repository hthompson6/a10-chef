resource_name :a10_syn_cookie

property :a10_name, String, name_property: true
property :on_threshold, Integer
property :enable, [true, false]
property :off_threshold, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/syn-cookie"
    on_threshold = new_resource.on_threshold
    enable = new_resource.enable
    off_threshold = new_resource.off_threshold
    uuid = new_resource.uuid

    params = { "syn-cookie": {"on-threshold": on_threshold,
        "enable": enable,
        "off-threshold": off_threshold,
        "uuid": uuid,} }

    params[:"syn-cookie"].each do |k, v|
        if not v 
            params[:"syn-cookie"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating syn-cookie') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/syn-cookie"
    on_threshold = new_resource.on_threshold
    enable = new_resource.enable
    off_threshold = new_resource.off_threshold
    uuid = new_resource.uuid

    params = { "syn-cookie": {"on-threshold": on_threshold,
        "enable": enable,
        "off-threshold": off_threshold,
        "uuid": uuid,} }

    params[:"syn-cookie"].each do |k, v|
        if not v
            params[:"syn-cookie"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["syn-cookie"].each do |k, v|
        if v != params[:"syn-cookie"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating syn-cookie') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/syn-cookie"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting syn-cookie') do
            client.delete(url)
        end
    end
end