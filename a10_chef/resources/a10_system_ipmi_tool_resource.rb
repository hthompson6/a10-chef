resource_name :a10_system_ipmi_tool

property :a10_name, String, name_property: true
property :cmd, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/ipmi/"
    get_url = "/axapi/v3/system/ipmi/tool"
    cmd = new_resource.cmd

    params = { "tool": {"cmd": cmd,} }

    params[:"tool"].each do |k, v|
        if not v 
            params[:"tool"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tool') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/tool"
    cmd = new_resource.cmd

    params = { "tool": {"cmd": cmd,} }

    params[:"tool"].each do |k, v|
        if not v
            params[:"tool"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tool"].each do |k, v|
        if v != params[:"tool"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tool') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi/tool"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tool') do
            client.delete(url)
        end
    end
end