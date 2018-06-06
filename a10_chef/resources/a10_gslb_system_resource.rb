resource_name :a10_gslb_system

property :a10_name, String, name_property: true
property :gslb_service_ip, [true, false]
property :gslb_site, [true, false]
property :ip_ttl, Integer
property :gslb_group, [true, false]
property :slb_device, [true, false]
property :hostname, [true, false]
property :a10_module, [true, false]
property :wait, Integer
property :age_interval, Integer
property :geo_location_iana, [true, false]
property :ttl, Integer
property :slb_server, [true, false]
property :slb_virtual_server, [true, false]
property :gslb_load_file_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/"
    get_url = "/axapi/v3/gslb/system"
    gslb_service_ip = new_resource.gslb_service_ip
    gslb_site = new_resource.gslb_site
    ip_ttl = new_resource.ip_ttl
    gslb_group = new_resource.gslb_group
    slb_device = new_resource.slb_device
    hostname = new_resource.hostname
    a10_name = new_resource.a10_name
    wait = new_resource.wait
    age_interval = new_resource.age_interval
    geo_location_iana = new_resource.geo_location_iana
    ttl = new_resource.ttl
    slb_server = new_resource.slb_server
    slb_virtual_server = new_resource.slb_virtual_server
    gslb_load_file_list = new_resource.gslb_load_file_list
    uuid = new_resource.uuid

    params = { "system": {"gslb-service-ip": gslb_service_ip,
        "gslb-site": gslb_site,
        "ip-ttl": ip_ttl,
        "gslb-group": gslb_group,
        "slb-device": slb_device,
        "hostname": hostname,
        "module": a10_module,
        "wait": wait,
        "age-interval": age_interval,
        "geo-location-iana": geo_location_iana,
        "ttl": ttl,
        "slb-server": slb_server,
        "slb-virtual-server": slb_virtual_server,
        "gslb-load-file-list": gslb_load_file_list,
        "uuid": uuid,} }

    params[:"system"].each do |k, v|
        if not v 
            params[:"system"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/system"
    gslb_service_ip = new_resource.gslb_service_ip
    gslb_site = new_resource.gslb_site
    ip_ttl = new_resource.ip_ttl
    gslb_group = new_resource.gslb_group
    slb_device = new_resource.slb_device
    hostname = new_resource.hostname
    a10_name = new_resource.a10_name
    wait = new_resource.wait
    age_interval = new_resource.age_interval
    geo_location_iana = new_resource.geo_location_iana
    ttl = new_resource.ttl
    slb_server = new_resource.slb_server
    slb_virtual_server = new_resource.slb_virtual_server
    gslb_load_file_list = new_resource.gslb_load_file_list
    uuid = new_resource.uuid

    params = { "system": {"gslb-service-ip": gslb_service_ip,
        "gslb-site": gslb_site,
        "ip-ttl": ip_ttl,
        "gslb-group": gslb_group,
        "slb-device": slb_device,
        "hostname": hostname,
        "module": a10_module,
        "wait": wait,
        "age-interval": age_interval,
        "geo-location-iana": geo_location_iana,
        "ttl": ttl,
        "slb-server": slb_server,
        "slb-virtual-server": slb_virtual_server,
        "gslb-load-file-list": gslb_load_file_list,
        "uuid": uuid,} }

    params[:"system"].each do |k, v|
        if not v
            params[:"system"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system"].each do |k, v|
        if v != params[:"system"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/system"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system') do
            client.delete(url)
        end
    end
end