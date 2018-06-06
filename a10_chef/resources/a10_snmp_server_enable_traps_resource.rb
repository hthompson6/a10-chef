resource_name :a10_snmp_server_enable_traps

property :a10_name, String, name_property: true
property :lldp, [true, false]
property :all, [true, false]
property :slb_change, Hash
property :uuid, String
property :lsn, Hash
property :vrrp_a, Hash
property :snmp, Hash
property :system, Hash
property :ssl, Hash
property :vcs, Hash
property :routing, Hash
property :gslb, Hash
property :slb, Hash
property :network, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/"
    get_url = "/axapi/v3/snmp-server/enable/traps"
    lldp = new_resource.lldp
    all = new_resource.all
    slb_change = new_resource.slb_change
    uuid = new_resource.uuid
    lsn = new_resource.lsn
    vrrp_a = new_resource.vrrp_a
    snmp = new_resource.snmp
    system = new_resource.system
    ssl = new_resource.ssl
    vcs = new_resource.vcs
    routing = new_resource.routing
    gslb = new_resource.gslb
    slb = new_resource.slb
    network = new_resource.network

    params = { "traps": {"lldp": lldp,
        "all": all,
        "slb-change": slb_change,
        "uuid": uuid,
        "lsn": lsn,
        "vrrp-a": vrrp_a,
        "snmp": snmp,
        "system": system,
        "ssl": ssl,
        "vcs": vcs,
        "routing": routing,
        "gslb": gslb,
        "slb": slb,
        "network": network,} }

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
    url = "/axapi/v3/snmp-server/enable/traps"
    lldp = new_resource.lldp
    all = new_resource.all
    slb_change = new_resource.slb_change
    uuid = new_resource.uuid
    lsn = new_resource.lsn
    vrrp_a = new_resource.vrrp_a
    snmp = new_resource.snmp
    system = new_resource.system
    ssl = new_resource.ssl
    vcs = new_resource.vcs
    routing = new_resource.routing
    gslb = new_resource.gslb
    slb = new_resource.slb
    network = new_resource.network

    params = { "traps": {"lldp": lldp,
        "all": all,
        "slb-change": slb_change,
        "uuid": uuid,
        "lsn": lsn,
        "vrrp-a": vrrp_a,
        "snmp": snmp,
        "system": system,
        "ssl": ssl,
        "vcs": vcs,
        "routing": routing,
        "gslb": gslb,
        "slb": slb,
        "network": network,} }

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
    url = "/axapi/v3/snmp-server/enable/traps"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting traps') do
            client.delete(url)
        end
    end
end