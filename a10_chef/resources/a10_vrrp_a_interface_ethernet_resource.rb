resource_name :a10_vrrp_a_interface_ethernet

property :a10_name, String, name_property: true
property :both, [true, false]
property :uuid, String
property :vlan, Integer
property :user_tag, String
property :ethernet_val, String,required: true
property :router_interface, [true, false]
property :no_heartbeat, [true, false]
property :server_interface, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/interface/ethernet/"
    get_url = "/axapi/v3/vrrp-a/interface/ethernet/%<ethernet-val>s"
    both = new_resource.both
    uuid = new_resource.uuid
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    ethernet_val = new_resource.ethernet_val
    router_interface = new_resource.router_interface
    no_heartbeat = new_resource.no_heartbeat
    server_interface = new_resource.server_interface

    params = { "ethernet": {"both": both,
        "uuid": uuid,
        "vlan": vlan,
        "user-tag": user_tag,
        "ethernet-val": ethernet_val,
        "router-interface": router_interface,
        "no-heartbeat": no_heartbeat,
        "server-interface": server_interface,} }

    params[:"ethernet"].each do |k, v|
        if not v 
            params[:"ethernet"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ethernet') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/interface/ethernet/%<ethernet-val>s"
    both = new_resource.both
    uuid = new_resource.uuid
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    ethernet_val = new_resource.ethernet_val
    router_interface = new_resource.router_interface
    no_heartbeat = new_resource.no_heartbeat
    server_interface = new_resource.server_interface

    params = { "ethernet": {"both": both,
        "uuid": uuid,
        "vlan": vlan,
        "user-tag": user_tag,
        "ethernet-val": ethernet_val,
        "router-interface": router_interface,
        "no-heartbeat": no_heartbeat,
        "server-interface": server_interface,} }

    params[:"ethernet"].each do |k, v|
        if not v
            params[:"ethernet"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ethernet"].each do |k, v|
        if v != params[:"ethernet"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ethernet') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/interface/ethernet/%<ethernet-val>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ethernet') do
            client.delete(url)
        end
    end
end