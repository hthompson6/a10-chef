resource_name :a10_snmp_server_enable_traps_gslb

property :a10_name, String, name_property: true
property :all, [true, false]
property :group, [true, false]
property :uuid, String
property :zone, [true, false]
property :site, [true, false]
property :service_ip, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/gslb"
    all = new_resource.all
    group = new_resource.group
    uuid = new_resource.uuid
    zone = new_resource.zone
    site = new_resource.site
    service_ip = new_resource.service_ip

    params = { "gslb": {"all": all,
        "group": group,
        "uuid": uuid,
        "zone": zone,
        "site": site,
        "service-ip": service_ip,} }

    params[:"gslb"].each do |k, v|
        if not v 
            params[:"gslb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating gslb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/gslb"
    all = new_resource.all
    group = new_resource.group
    uuid = new_resource.uuid
    zone = new_resource.zone
    site = new_resource.site
    service_ip = new_resource.service_ip

    params = { "gslb": {"all": all,
        "group": group,
        "uuid": uuid,
        "zone": zone,
        "site": site,
        "service-ip": service_ip,} }

    params[:"gslb"].each do |k, v|
        if not v
            params[:"gslb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["gslb"].each do |k, v|
        if v != params[:"gslb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating gslb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/gslb"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting gslb') do
            client.delete(url)
        end
    end
end