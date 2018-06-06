resource_name :a10_gslb_site_slb_dev

property :a10_name, String, name_property: true
property :health_check_action, ['health-check','health-check-disable']
property :client_ip, String
property :uuid, String
property :device_name, String,required: true
property :proto_compatible, [true, false]
property :user_tag, String
property :auto_map, [true, false]
property :proto_aging_time, Integer
property :rdt_value, Integer
property :gateway_ip_addr, String
property :vip_server, Hash
property :ip_address, String
property :proto_aging_fast, [true, false]
property :auto_detect, ['ip','port','ip-and-port','disabled']
property :max_client, Integer
property :admin_preference, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/"
    get_url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s"
    health_check_action = new_resource.health_check_action
    client_ip = new_resource.client_ip
    uuid = new_resource.uuid
    device_name = new_resource.device_name
    proto_compatible = new_resource.proto_compatible
    user_tag = new_resource.user_tag
    auto_map = new_resource.auto_map
    proto_aging_time = new_resource.proto_aging_time
    rdt_value = new_resource.rdt_value
    gateway_ip_addr = new_resource.gateway_ip_addr
    vip_server = new_resource.vip_server
    ip_address = new_resource.ip_address
    proto_aging_fast = new_resource.proto_aging_fast
    auto_detect = new_resource.auto_detect
    max_client = new_resource.max_client
    admin_preference = new_resource.admin_preference

    params = { "slb-dev": {"health-check-action": health_check_action,
        "client-ip": client_ip,
        "uuid": uuid,
        "device-name": device_name,
        "proto-compatible": proto_compatible,
        "user-tag": user_tag,
        "auto-map": auto_map,
        "proto-aging-time": proto_aging_time,
        "rdt-value": rdt_value,
        "gateway-ip-addr": gateway_ip_addr,
        "vip-server": vip_server,
        "ip-address": ip_address,
        "proto-aging-fast": proto_aging_fast,
        "auto-detect": auto_detect,
        "max-client": max_client,
        "admin-preference": admin_preference,} }

    params[:"slb-dev"].each do |k, v|
        if not v 
            params[:"slb-dev"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating slb-dev') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s"
    health_check_action = new_resource.health_check_action
    client_ip = new_resource.client_ip
    uuid = new_resource.uuid
    device_name = new_resource.device_name
    proto_compatible = new_resource.proto_compatible
    user_tag = new_resource.user_tag
    auto_map = new_resource.auto_map
    proto_aging_time = new_resource.proto_aging_time
    rdt_value = new_resource.rdt_value
    gateway_ip_addr = new_resource.gateway_ip_addr
    vip_server = new_resource.vip_server
    ip_address = new_resource.ip_address
    proto_aging_fast = new_resource.proto_aging_fast
    auto_detect = new_resource.auto_detect
    max_client = new_resource.max_client
    admin_preference = new_resource.admin_preference

    params = { "slb-dev": {"health-check-action": health_check_action,
        "client-ip": client_ip,
        "uuid": uuid,
        "device-name": device_name,
        "proto-compatible": proto_compatible,
        "user-tag": user_tag,
        "auto-map": auto_map,
        "proto-aging-time": proto_aging_time,
        "rdt-value": rdt_value,
        "gateway-ip-addr": gateway_ip_addr,
        "vip-server": vip_server,
        "ip-address": ip_address,
        "proto-aging-fast": proto_aging_fast,
        "auto-detect": auto_detect,
        "max-client": max_client,
        "admin-preference": admin_preference,} }

    params[:"slb-dev"].each do |k, v|
        if not v
            params[:"slb-dev"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["slb-dev"].each do |k, v|
        if v != params[:"slb-dev"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating slb-dev') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting slb-dev') do
            client.delete(url)
        end
    end
end