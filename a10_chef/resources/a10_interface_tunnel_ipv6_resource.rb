resource_name :a10_interface_tunnel_ipv6

property :a10_name, String, name_property: true
property :router, Hash
property :address_cfg, Array
property :ospf, Hash
property :ipv6_enable, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/tunnel/%<ifnum>s/"
    get_url = "/axapi/v3/interface/tunnel/%<ifnum>s/ipv6"
    router = new_resource.router
    address_cfg = new_resource.address_cfg
    ospf = new_resource.ospf
    ipv6_enable = new_resource.ipv6_enable
    uuid = new_resource.uuid

    params = { "ipv6": {"router": router,
        "address-cfg": address_cfg,
        "ospf": ospf,
        "ipv6-enable": ipv6_enable,
        "uuid": uuid,} }

    params[:"ipv6"].each do |k, v|
        if not v 
            params[:"ipv6"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv6') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s/ipv6"
    router = new_resource.router
    address_cfg = new_resource.address_cfg
    ospf = new_resource.ospf
    ipv6_enable = new_resource.ipv6_enable
    uuid = new_resource.uuid

    params = { "ipv6": {"router": router,
        "address-cfg": address_cfg,
        "ospf": ospf,
        "ipv6-enable": ipv6_enable,
        "uuid": uuid,} }

    params[:"ipv6"].each do |k, v|
        if not v
            params[:"ipv6"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv6"].each do |k, v|
        if v != params[:"ipv6"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv6') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/tunnel/%<ifnum>s/ipv6"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv6') do
            client.delete(url)
        end
    end
end