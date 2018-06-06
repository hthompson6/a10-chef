resource_name :a10_import_periodic_xml_schema

property :a10_name, String, name_property: true
property :xml_schema, String,required: true
property :use_mgmt_port, [true, false]
property :uuid, String
property :remote_file, String
property :period, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/xml-schema/"
    get_url = "/axapi/v3/import-periodic/xml-schema/%<xml-schema>s"
    xml_schema = new_resource.xml_schema
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "xml-schema": {"xml-schema": xml_schema,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

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
    url = "/axapi/v3/import-periodic/xml-schema/%<xml-schema>s"
    xml_schema = new_resource.xml_schema
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "xml-schema": {"xml-schema": xml_schema,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

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
    url = "/axapi/v3/import-periodic/xml-schema/%<xml-schema>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting xml-schema') do
            client.delete(url)
        end
    end
end