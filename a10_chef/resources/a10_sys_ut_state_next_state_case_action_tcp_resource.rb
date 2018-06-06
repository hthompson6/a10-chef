resource_name :a10_sys_ut_state_next_state_case_action_tcp

property :a10_name, String, name_property: true
property :uuid, String
property :checksum, ['valid','invalid']
property :seq_number, ['valid','invalid']
property :nat_pool, String
property :src_port, Integer
property :urgent, ['valid','invalid']
property :window, ['valid','invalid']
property :ack_seq_number, ['valid','invalid']
property :flags, Hash
property :dest_port, [true, false]
property :dest_port_value, Integer
property :options, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/"
    get_url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/tcp"
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    seq_number = new_resource.seq_number
    nat_pool = new_resource.nat_pool
    src_port = new_resource.src_port
    urgent = new_resource.urgent
    window = new_resource.window
    ack_seq_number = new_resource.ack_seq_number
    flags = new_resource.flags
    dest_port = new_resource.dest_port
    dest_port_value = new_resource.dest_port_value
    options = new_resource.options

    params = { "tcp": {"uuid": uuid,
        "checksum": checksum,
        "seq-number": seq_number,
        "nat-pool": nat_pool,
        "src-port": src_port,
        "urgent": urgent,
        "window": window,
        "ack-seq-number": ack_seq_number,
        "flags": flags,
        "dest-port": dest_port,
        "dest-port-value": dest_port_value,
        "options": options,} }

    params[:"tcp"].each do |k, v|
        if not v 
            params[:"tcp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tcp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/tcp"
    uuid = new_resource.uuid
    checksum = new_resource.checksum
    seq_number = new_resource.seq_number
    nat_pool = new_resource.nat_pool
    src_port = new_resource.src_port
    urgent = new_resource.urgent
    window = new_resource.window
    ack_seq_number = new_resource.ack_seq_number
    flags = new_resource.flags
    dest_port = new_resource.dest_port
    dest_port_value = new_resource.dest_port_value
    options = new_resource.options

    params = { "tcp": {"uuid": uuid,
        "checksum": checksum,
        "seq-number": seq_number,
        "nat-pool": nat_pool,
        "src-port": src_port,
        "urgent": urgent,
        "window": window,
        "ack-seq-number": ack_seq_number,
        "flags": flags,
        "dest-port": dest_port,
        "dest-port-value": dest_port_value,
        "options": options,} }

    params[:"tcp"].each do |k, v|
        if not v
            params[:"tcp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tcp"].each do |k, v|
        if v != params[:"tcp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tcp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/state/%<name>s/next-state/%<name>s/case/%<case-number>s/action/%<direction>s/tcp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tcp') do
            client.delete(url)
        end
    end
end