resource_name :a10_vrrp_a_interface_trunk

property :a10_name, String, name_property: true
property :both, [true, false]
property :uuid, String
property :vlan, Integer
property :user_tag, String
property :router_interface, [true, false]
property :no_heartbeat, [true, false]
property :server_interface, [true, false]
property :trunk_val, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/interface/trunk/"
    get_url = "/axapi/v3/vrrp-a/interface/trunk/%<trunk-val>s"
    both = new_resource.both
    uuid = new_resource.uuid
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    router_interface = new_resource.router_interface
    no_heartbeat = new_resource.no_heartbeat
    server_interface = new_resource.server_interface
    trunk_val = new_resource.trunk_val

    params = { "trunk": {"both": both,
        "uuid": uuid,
        "vlan": vlan,
        "user-tag": user_tag,
        "router-interface": router_interface,
        "no-heartbeat": no_heartbeat,
        "server-interface": server_interface,
        "trunk-val": trunk_val,} }

    params[:"trunk"].each do |k, v|
        if not v 
            params[:"trunk"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating trunk') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/interface/trunk/%<trunk-val>s"
    both = new_resource.both
    uuid = new_resource.uuid
    vlan = new_resource.vlan
    user_tag = new_resource.user_tag
    router_interface = new_resource.router_interface
    no_heartbeat = new_resource.no_heartbeat
    server_interface = new_resource.server_interface
    trunk_val = new_resource.trunk_val

    params = { "trunk": {"both": both,
        "uuid": uuid,
        "vlan": vlan,
        "user-tag": user_tag,
        "router-interface": router_interface,
        "no-heartbeat": no_heartbeat,
        "server-interface": server_interface,
        "trunk-val": trunk_val,} }

    params[:"trunk"].each do |k, v|
        if not v
            params[:"trunk"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["trunk"].each do |k, v|
        if v != params[:"trunk"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating trunk') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vrrp-a/interface/trunk/%<trunk-val>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trunk') do
            client.delete(url)
        end
    end
end