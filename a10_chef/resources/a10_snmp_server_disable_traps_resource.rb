resource_name :a10_snmp_server_disable_traps

property :a10_name, String, name_property: true
property :all, [true, false]
property :slb_change, [true, false]
property :uuid, String
property :vrrp_a, [true, false]
property :snmp, [true, false]
property :gslb, [true, false]
property :slb, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/disable/"
    get_url = "/axapi/v3/snmp-server/disable/traps"
    all = new_resource.all
    slb_change = new_resource.slb_change
    uuid = new_resource.uuid
    vrrp_a = new_resource.vrrp_a
    snmp = new_resource.snmp
    gslb = new_resource.gslb
    slb = new_resource.slb

    params = { "traps": {"all": all,
        "slb-change": slb_change,
        "uuid": uuid,
        "vrrp-a": vrrp_a,
        "snmp": snmp,
        "gslb": gslb,
        "slb": slb,} }

    params[:"traps"].each do |k, v|
        if not v 
            params[:"traps"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating traps') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/disable/traps"
    all = new_resource.all
    slb_change = new_resource.slb_change
    uuid = new_resource.uuid
    vrrp_a = new_resource.vrrp_a
    snmp = new_resource.snmp
    gslb = new_resource.gslb
    slb = new_resource.slb

    params = { "traps": {"all": all,
        "slb-change": slb_change,
        "uuid": uuid,
        "vrrp-a": vrrp_a,
        "snmp": snmp,
        "gslb": gslb,
        "slb": slb,} }

    params[:"traps"].each do |k, v|
        if not v
            params[:"traps"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["traps"].each do |k, v|
        if v != params[:"traps"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating traps') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/disable/traps"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting traps') do
            client.delete(url)
        end
    end
end