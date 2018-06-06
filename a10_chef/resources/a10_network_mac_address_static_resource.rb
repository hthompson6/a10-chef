resource_name :a10_network_mac_address_static

property :a10_name, String, name_property: true
property :dest, [true, false]
property :mac, String,required: true
property :vlan, Integer,required: true
property :port, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/mac-address/static/"
    get_url = "/axapi/v3/network/mac-address/static/%<mac>s+%<vlan>s"
    dest = new_resource.dest
    mac = new_resource.mac
    vlan = new_resource.vlan
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "static": {"dest": dest,
        "mac": mac,
        "vlan": vlan,
        "port": port,
        "uuid": uuid,} }

    params[:"static"].each do |k, v|
        if not v 
            params[:"static"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating static') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/mac-address/static/%<mac>s+%<vlan>s"
    dest = new_resource.dest
    mac = new_resource.mac
    vlan = new_resource.vlan
    port = new_resource.port
    uuid = new_resource.uuid

    params = { "static": {"dest": dest,
        "mac": mac,
        "vlan": vlan,
        "port": port,
        "uuid": uuid,} }

    params[:"static"].each do |k, v|
        if not v
            params[:"static"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["static"].each do |k, v|
        if v != params[:"static"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating static') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/mac-address/static/%<mac>s+%<vlan>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static') do
            client.delete(url)
        end
    end
end