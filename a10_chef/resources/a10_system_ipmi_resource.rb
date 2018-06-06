resource_name :a10_system_ipmi

property :a10_name, String, name_property: true
property :reset, [true, false]
property :ip, Hash
property :ipsrc, Hash
property :tool, Hash
property :user, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/ipmi"
    reset = new_resource.reset
    ip = new_resource.ip
    ipsrc = new_resource.ipsrc
    tool = new_resource.tool
    user = new_resource.user

    params = { "ipmi": {"reset": reset,
        "ip": ip,
        "ipsrc": ipsrc,
        "tool": tool,
        "user": user,} }

    params[:"ipmi"].each do |k, v|
        if not v 
            params[:"ipmi"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipmi') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi"
    reset = new_resource.reset
    ip = new_resource.ip
    ipsrc = new_resource.ipsrc
    tool = new_resource.tool
    user = new_resource.user

    params = { "ipmi": {"reset": reset,
        "ip": ip,
        "ipsrc": ipsrc,
        "tool": tool,
        "user": user,} }

    params[:"ipmi"].each do |k, v|
        if not v
            params[:"ipmi"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipmi"].each do |k, v|
        if v != params[:"ipmi"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipmi') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipmi"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipmi') do
            client.delete(url)
        end
    end
end