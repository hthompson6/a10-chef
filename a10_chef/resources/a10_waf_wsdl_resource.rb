resource_name :a10_waf_wsdl

property :a10_name, String, name_property: true
property :uuid, String
property :max_filesize, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/waf/"
    get_url = "/axapi/v3/waf/wsdl"
    uuid = new_resource.uuid
    max_filesize = new_resource.max_filesize

    params = { "wsdl": {"uuid": uuid,
        "max-filesize": max_filesize,} }

    params[:"wsdl"].each do |k, v|
        if not v 
            params[:"wsdl"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating wsdl') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/wsdl"
    uuid = new_resource.uuid
    max_filesize = new_resource.max_filesize

    params = { "wsdl": {"uuid": uuid,
        "max-filesize": max_filesize,} }

    params[:"wsdl"].each do |k, v|
        if not v
            params[:"wsdl"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["wsdl"].each do |k, v|
        if v != params[:"wsdl"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating wsdl') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/wsdl"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting wsdl') do
            client.delete(url)
        end
    end
end