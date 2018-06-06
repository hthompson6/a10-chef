resource_name :a10_ip_nat_pool

property :a10_name, String, name_property: true
property :use_if_ip, [true, false]
property :uuid, String
property :start_address, String
property :vrid, Integer
property :netmask, String
property :end_address, String
property :ip_rr, [true, false]
property :ethernet, String
property :scaleout_device_id, Integer
property :gateway, String
property :pool_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/pool/"
    get_url = "/axapi/v3/ip/nat/pool/%<pool-name>s"
    use_if_ip = new_resource.use_if_ip
    uuid = new_resource.uuid
    start_address = new_resource.start_address
    vrid = new_resource.vrid
    netmask = new_resource.netmask
    end_address = new_resource.end_address
    ip_rr = new_resource.ip_rr
    ethernet = new_resource.ethernet
    scaleout_device_id = new_resource.scaleout_device_id
    gateway = new_resource.gateway
    pool_name = new_resource.pool_name

    params = { "pool": {"use-if-ip": use_if_ip,
        "uuid": uuid,
        "start-address": start_address,
        "vrid": vrid,
        "netmask": netmask,
        "end-address": end_address,
        "ip-rr": ip_rr,
        "ethernet": ethernet,
        "scaleout-device-id": scaleout_device_id,
        "gateway": gateway,
        "pool-name": pool_name,} }

    params[:"pool"].each do |k, v|
        if not v 
            params[:"pool"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pool') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/pool/%<pool-name>s"
    use_if_ip = new_resource.use_if_ip
    uuid = new_resource.uuid
    start_address = new_resource.start_address
    vrid = new_resource.vrid
    netmask = new_resource.netmask
    end_address = new_resource.end_address
    ip_rr = new_resource.ip_rr
    ethernet = new_resource.ethernet
    scaleout_device_id = new_resource.scaleout_device_id
    gateway = new_resource.gateway
    pool_name = new_resource.pool_name

    params = { "pool": {"use-if-ip": use_if_ip,
        "uuid": uuid,
        "start-address": start_address,
        "vrid": vrid,
        "netmask": netmask,
        "end-address": end_address,
        "ip-rr": ip_rr,
        "ethernet": ethernet,
        "scaleout-device-id": scaleout_device_id,
        "gateway": gateway,
        "pool-name": pool_name,} }

    params[:"pool"].each do |k, v|
        if not v
            params[:"pool"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pool"].each do |k, v|
        if v != params[:"pool"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pool') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/nat/pool/%<pool-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pool') do
            client.delete(url)
        end
    end
end