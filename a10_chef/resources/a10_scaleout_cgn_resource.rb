resource_name :a10_scaleout_cgn

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/scaleout-cgn"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "scaleout-cgn": {"enable": enable,
        "uuid": uuid,} }

    params[:"scaleout-cgn"].each do |k, v|
        if not v 
            params[:"scaleout-cgn"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating scaleout-cgn') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout-cgn"
    enable = new_resource.enable
    uuid = new_resource.uuid

    params = { "scaleout-cgn": {"enable": enable,
        "uuid": uuid,} }

    params[:"scaleout-cgn"].each do |k, v|
        if not v
            params[:"scaleout-cgn"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["scaleout-cgn"].each do |k, v|
        if v != params[:"scaleout-cgn"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating scaleout-cgn') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/scaleout-cgn"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting scaleout-cgn') do
            client.delete(url)
        end
    end
end