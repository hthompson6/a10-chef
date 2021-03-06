resource_name :a10_report

property :a10_name, String, name_property: true
property :debug, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/report"
    debug = new_resource.debug

    params = { "report": {"debug": debug,} }

    params[:"report"].each do |k, v|
        if not v 
            params[:"report"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating report') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/report"
    debug = new_resource.debug

    params = { "report": {"debug": debug,} }

    params[:"report"].each do |k, v|
        if not v
            params[:"report"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["report"].each do |k, v|
        if v != params[:"report"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating report') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/report"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting report') do
            client.delete(url)
        end
    end
end