resource_name :a10_overlay_tunnel_vtep_host

property :a10_name, String, name_property: true
property :destination_vtep, String,required: true
property :ip_addr, String,required: true
property :overlay_mac_addr, String,required: true
property :vni, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/host/"
    get_url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/host/%<ip-addr>s+%<overlay-mac-addr>s+%<vni>s+%<destination-vtep>s"
    destination_vtep = new_resource.destination_vtep
    ip_addr = new_resource.ip_addr
    overlay_mac_addr = new_resource.overlay_mac_addr
    vni = new_resource.vni
    uuid = new_resource.uuid

    params = { "host": {"destination-vtep": destination_vtep,
        "ip-addr": ip_addr,
        "overlay-mac-addr": overlay_mac_addr,
        "vni": vni,
        "uuid": uuid,} }

    params[:"host"].each do |k, v|
        if not v 
            params[:"host"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating host') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/host/%<ip-addr>s+%<overlay-mac-addr>s+%<vni>s+%<destination-vtep>s"
    destination_vtep = new_resource.destination_vtep
    ip_addr = new_resource.ip_addr
    overlay_mac_addr = new_resource.overlay_mac_addr
    vni = new_resource.vni
    uuid = new_resource.uuid

    params = { "host": {"destination-vtep": destination_vtep,
        "ip-addr": ip_addr,
        "overlay-mac-addr": overlay_mac_addr,
        "vni": vni,
        "uuid": uuid,} }

    params[:"host"].each do |k, v|
        if not v
            params[:"host"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["host"].each do |k, v|
        if v != params[:"host"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating host') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-tunnel/vtep/%<id>s/host/%<ip-addr>s+%<overlay-mac-addr>s+%<vni>s+%<destination-vtep>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting host') do
            client.delete(url)
        end
    end
end