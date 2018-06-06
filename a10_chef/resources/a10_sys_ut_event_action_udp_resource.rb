resource_name :a10_sys_ut_event_action_udp

property :a10_name, String, name_property: true
property :uuid, String
property :checksum, ['valid','invalid']
property :nat_pool, String
property :src_port, Integer
property :length, Integer
property :dest_port, [true, false]
property :dest_port_value, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/"
    get_url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/udp"
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    nat_pool = new_resource.nat_pool
    src_port = new_resource.src_port
    length = new_resource.length
    dest_port = new_resource.dest_port
    dest_port_value = new_resource.dest_port_value

    params = { "udp": {"uuid": uuid,
        "checksum": checksum,
        "nat-pool": nat_pool,
        "src-port": src_port,
        "length": length,
        "dest-port": dest_port,
        "dest-port-value": dest_port_value,} }

    params[:"udp"].each do |k, v|
        if not v 
            params[:"udp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating udp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/udp"
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    nat_pool = new_resource.nat_pool
    src_port = new_resource.src_port
    length = new_resource.length
    dest_port = new_resource.dest_port
    dest_port_value = new_resource.dest_port_value

    params = { "udp": {"uuid": uuid,
        "checksum": checksum,
        "nat-pool": nat_pool,
        "src-port": src_port,
        "length": length,
        "dest-port": dest_port,
        "dest-port-value": dest_port_value,} }

    params[:"udp"].each do |k, v|
        if not v
            params[:"udp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["udp"].each do |k, v|
        if v != params[:"udp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating udp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/event/%<event-number>s/action/%<direction>s/udp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting udp') do
            client.delete(url)
        end
    end
end