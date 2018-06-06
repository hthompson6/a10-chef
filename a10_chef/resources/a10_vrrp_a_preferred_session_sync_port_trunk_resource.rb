resource_name :a10_vrrp_a_preferred_session_sync_port_trunk

property :a10_name, String, name_property: true
property :pre_vlan, Integer
property :uuid, String
property :pre_trunk, Integer,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/preferred-session-sync-port/trunk/"
    get_url = "/axapi/v3/vrrp-a/preferred-session-sync-port/trunk/%<pre-trunk>s"
    pre_vlan = new_resource.pre_vlan
    uuid = new_resource.uuid
    pre_trunk = new_resource.pre_trunk

    params = { "trunk": {"pre-vlan": pre_vlan,
        "uuid": uuid,
        "pre-trunk": pre_trunk,} }

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
    url = "/axapi/v3/vrrp-a/preferred-session-sync-port/trunk/%<pre-trunk>s"
    pre_vlan = new_resource.pre_vlan
    uuid = new_resource.uuid
    pre_trunk = new_resource.pre_trunk

    params = { "trunk": {"pre-vlan": pre_vlan,
        "uuid": uuid,
        "pre-trunk": pre_trunk,} }

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
    url = "/axapi/v3/vrrp-a/preferred-session-sync-port/trunk/%<pre-trunk>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting trunk') do
            client.delete(url)
        end
    end
end