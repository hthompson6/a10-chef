resource_name :a10_report_debug

property :a10_name, String, name_property: true
property :log, [true, false]
property :sflow, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/report/"
    get_url = "/axapi/v3/report/debug"
    log = new_resource.log
    sflow = new_resource.sflow

    params = { "debug": {"log": log,
        "sflow": sflow,} }

    params[:"debug"].each do |k, v|
        if not v 
            params[:"debug"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating debug') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/report/debug"
    log = new_resource.log
    sflow = new_resource.sflow

    params = { "debug": {"log": log,
        "sflow": sflow,} }

    params[:"debug"].each do |k, v|
        if not v
            params[:"debug"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["debug"].each do |k, v|
        if v != params[:"debug"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating debug') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/report/debug"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting debug') do
            client.delete(url)
        end
    end
end