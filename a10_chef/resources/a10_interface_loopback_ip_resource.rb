resource_name :a10_interface_loopback_ip

property :a10_name, String, name_property: true
property :address_list, Array
property :ospf, Hash
property :uuid, String
property :rip, Hash
property :router, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/loopback/%<ifnum>s/"
    get_url = "/axapi/v3/interface/loopback/%<ifnum>s/ip"
    address_list = new_resource.address_list
    ospf = new_resource.ospf
    uuid = new_resource.uuid
    rip = new_resource.rip
    router = new_resource.router

    params = { "ip": {"address-list": address_list,
        "ospf": ospf,
        "uuid": uuid,
        "rip": rip,
        "router": router,} }

    params[:"ip"].each do |k, v|
        if not v 
            params[:"ip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s/ip"
    address_list = new_resource.address_list
    ospf = new_resource.ospf
    uuid = new_resource.uuid
    rip = new_resource.rip
    router = new_resource.router

    params = { "ip": {"address-list": address_list,
        "ospf": ospf,
        "uuid": uuid,
        "rip": rip,
        "router": router,} }

    params[:"ip"].each do |k, v|
        if not v
            params[:"ip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip"].each do |k, v|
        if v != params[:"ip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/loopback/%<ifnum>s/ip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip') do
            client.delete(url)
        end
    end
end