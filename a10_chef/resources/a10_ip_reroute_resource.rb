resource_name :a10_ip_reroute

property :a10_name, String, name_property: true
property :suppress_protocols, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/"
    get_url = "/axapi/v3/ip/reroute"
    suppress_protocols = new_resource.suppress_protocols
    uuid = new_resource.uuid

    params = { "reroute": {"suppress-protocols": suppress_protocols,
        "uuid": uuid,} }

    params[:"reroute"].each do |k, v|
        if not v 
            params[:"reroute"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reroute') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/reroute"
    suppress_protocols = new_resource.suppress_protocols
    uuid = new_resource.uuid

    params = { "reroute": {"suppress-protocols": suppress_protocols,
        "uuid": uuid,} }

    params[:"reroute"].each do |k, v|
        if not v
            params[:"reroute"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reroute"].each do |k, v|
        if v != params[:"reroute"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reroute') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/reroute"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reroute') do
            client.delete(url)
        end
    end
end