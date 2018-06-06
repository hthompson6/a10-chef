resource_name :a10_slb_virtual_server_port_stats_file_inspection

property :a10_name, String, name_property: true
property :stats, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s/"
    get_url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s/stats?file-inspection=true"
    stats = new_resource.stats

    params = { "port": {"stats": stats,} }

    params[:"port"].each do |k, v|
        if not v 
            params[:"port"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating port') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s/stats?file-inspection=true"
    stats = new_resource.stats

    params = { "port": {"stats": stats,} }

    params[:"port"].each do |k, v|
        if not v
            params[:"port"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["port"].each do |k, v|
        if v != params[:"port"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating port') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/virtual-server/%<name>s/port/%<port-number>s+%<protocol>s/stats?file-inspection=true"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting port') do
            client.delete(url)
        end
    end
end