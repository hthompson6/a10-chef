resource_name :a10_snmp_server_enable_traps_vrrp_a

property :a10_name, String, name_property: true
property :active, [true, false]
property :standby, [true, false]
property :all, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/vrrp-a"
    active = new_resource.active
    standby = new_resource.standby
    all = new_resource.all
    uuid = new_resource.uuid

    params = { "vrrp-a": {"active": active,
        "standby": standby,
        "all": all,
        "uuid": uuid,} }

    params[:"vrrp-a"].each do |k, v|
        if not v 
            params[:"vrrp-a"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vrrp-a') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/vrrp-a"
    active = new_resource.active
    standby = new_resource.standby
    all = new_resource.all
    uuid = new_resource.uuid

    params = { "vrrp-a": {"active": active,
        "standby": standby,
        "all": all,
        "uuid": uuid,} }

    params[:"vrrp-a"].each do |k, v|
        if not v
            params[:"vrrp-a"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vrrp-a"].each do |k, v|
        if v != params[:"vrrp-a"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vrrp-a') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/vrrp-a"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vrrp-a') do
            client.delete(url)
        end
    end
end