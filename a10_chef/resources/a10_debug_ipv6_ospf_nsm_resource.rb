resource_name :a10_debug_ipv6_ospf_nsm

property :a10_name, String, name_property: true
property :interface, [true, false]
property :redistribute, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/ipv6/ospf/"
    get_url = "/axapi/v3/debug/ipv6/ospf/nsm"
    interface = new_resource.interface
    redistribute = new_resource.redistribute
    uuid = new_resource.uuid

    params = { "nsm": {"interface": interface,
        "redistribute": redistribute,
        "uuid": uuid,} }

    params[:"nsm"].each do |k, v|
        if not v 
            params[:"nsm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating nsm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf/nsm"
    interface = new_resource.interface
    redistribute = new_resource.redistribute
    uuid = new_resource.uuid

    params = { "nsm": {"interface": interface,
        "redistribute": redistribute,
        "uuid": uuid,} }

    params[:"nsm"].each do |k, v|
        if not v
            params[:"nsm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["nsm"].each do |k, v|
        if v != params[:"nsm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating nsm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/ipv6/ospf/nsm"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting nsm') do
            client.delete(url)
        end
    end
end