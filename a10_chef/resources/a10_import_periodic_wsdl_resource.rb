resource_name :a10_import_periodic_wsdl

property :a10_name, String, name_property: true
property :wsdl, String,required: true
property :use_mgmt_port, [true, false]
property :uuid, String
property :remote_file, String
property :period, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/import-periodic/wsdl/"
    get_url = "/axapi/v3/import-periodic/wsdl/%<wsdl>s"
    wsdl = new_resource.wsdl
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "wsdl": {"wsdl": wsdl,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

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
    url = "/axapi/v3/import-periodic/wsdl/%<wsdl>s"
    wsdl = new_resource.wsdl
    use_mgmt_port = new_resource.use_mgmt_port
    uuid = new_resource.uuid
    remote_file = new_resource.remote_file
    period = new_resource.period

    params = { "wsdl": {"wsdl": wsdl,
        "use-mgmt-port": use_mgmt_port,
        "uuid": uuid,
        "remote-file": remote_file,
        "period": period,} }

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
    url = "/axapi/v3/import-periodic/wsdl/%<wsdl>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting wsdl') do
            client.delete(url)
        end
    end
end