resource_name :a10_waf_xml_schema

property :a10_name, String, name_property: true
property :uuid, String
property :max_filesize, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/waf/"
    get_url = "/axapi/v3/waf/xml-schema"
    uuid = new_resource.uuid
    max_filesize = new_resource.max_filesize

    params = { "xml-schema": {"uuid": uuid,
        "max-filesize": max_filesize,} }

    params[:"xml-schema"].each do |k, v|
        if not v 
            params[:"xml-schema"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating xml-schema') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/xml-schema"
    uuid = new_resource.uuid
    max_filesize = new_resource.max_filesize

    params = { "xml-schema": {"uuid": uuid,
        "max-filesize": max_filesize,} }

    params[:"xml-schema"].each do |k, v|
        if not v
            params[:"xml-schema"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["xml-schema"].each do |k, v|
        if v != params[:"xml-schema"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating xml-schema') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/waf/xml-schema"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting xml-schema') do
            client.delete(url)
        end
    end
end