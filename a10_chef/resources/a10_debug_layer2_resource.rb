resource_name :a10_debug_layer2

property :a10_name, String, name_property: true
property :arp, [true, false]
property :all, [true, false]
property :uuid, String
property :trace, [true, false]
property :vlan, [true, false]
property :misc, [true, false]
property :interface, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/layer2"
    arp = new_resource.arp
    all = new_resource.all
    uuid = new_resource.uuid
    trace = new_resource.trace
    vlan = new_resource.vlan
    misc = new_resource.misc
    interface = new_resource.interface

    params = { "layer2": {"arp": arp,
        "all": all,
        "uuid": uuid,
        "trace": trace,
        "vlan": vlan,
        "misc": misc,
        "interface": interface,} }

    params[:"layer2"].each do |k, v|
        if not v 
            params[:"layer2"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating layer2') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/layer2"
    arp = new_resource.arp
    all = new_resource.all
    uuid = new_resource.uuid
    trace = new_resource.trace
    vlan = new_resource.vlan
    misc = new_resource.misc
    interface = new_resource.interface

    params = { "layer2": {"arp": arp,
        "all": all,
        "uuid": uuid,
        "trace": trace,
        "vlan": vlan,
        "misc": misc,
        "interface": interface,} }

    params[:"layer2"].each do |k, v|
        if not v
            params[:"layer2"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["layer2"].each do |k, v|
        if v != params[:"layer2"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating layer2') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/layer2"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting layer2') do
            client.delete(url)
        end
    end
end