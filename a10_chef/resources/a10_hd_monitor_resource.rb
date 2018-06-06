resource_name :a10_hd_monitor

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/hd-monitor"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "hd-monitor": {"enable": enable,
        "uuid": uuid,} }

    params[:"hd-monitor"].each do |k, v|
        if not v 
            params[:"hd-monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating hd-monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hd-monitor"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "hd-monitor": {"enable": enable,
        "uuid": uuid,} }

    params[:"hd-monitor"].each do |k, v|
        if not v
            params[:"hd-monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["hd-monitor"].each do |k, v|
        if v != params[:"hd-monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating hd-monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/hd-monitor"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting hd-monitor') do
            client.delete(url)
        end
    end
end