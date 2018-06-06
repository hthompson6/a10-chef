resource_name :a10_vrrp_a_preferred_session_sync_port_ethernet

property :a10_name, String, name_property: true
property :pre_eth, String,required: true
property :pre_vlan, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vrrp-a/preferred-session-sync-port/ethernet/"
    get_url = "/axapi/v3/vrrp-a/preferred-session-sync-port/ethernet/%<pre-eth>s"
    pre_eth = new_resource.pre_eth
    pre_vlan = new_resource.pre_vlan
    uuid = new_resource.uuid

    params = { "ethernet": {"pre-eth": pre_eth,
        "pre-vlan": pre_vlan,
        "uuid": uuid,} }

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
    url = "/axapi/v3/vrrp-a/preferred-session-sync-port/ethernet/%<pre-eth>s"
    pre_eth = new_resource.pre_eth
    pre_vlan = new_resource.pre_vlan
    uuid = new_resource.uuid

    params = { "ethernet": {"pre-eth": pre_eth,
        "pre-vlan": pre_vlan,
        "uuid": uuid,} }

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
    url = "/axapi/v3/vrrp-a/preferred-session-sync-port/ethernet/%<pre-eth>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ethernet') do
            client.delete(url)
        end
    end
end