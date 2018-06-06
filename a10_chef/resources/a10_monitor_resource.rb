resource_name :a10_monitor

property :a10_name, String, name_property: true
property :data_cpu, Integer
property :smp_type1, Integer
property :buffer_usage, Integer
property :uuid, String
property :buffer_drop, Integer
property :ctrl_cpu, Integer
property :warn_temp, Integer
property :disk, Integer
property :conn_type3, Integer
property :conn_type2, Integer
property :memory, Integer
property :smp_type2, Integer
property :smp_type3, Integer
property :conn_type1, Integer
property :conn_type0, Integer
property :smp_type0, Integer
property :smp_type4, Integer
property :conn_type4, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/monitor"
    data_cpu = new_resource.data_cpu
    smp_type1 = new_resource.smp_type1
    buffer_usage = new_resource.buffer_usage
    uuid = new_resource.uuid
    buffer_drop = new_resource.buffer_drop
    ctrl_cpu = new_resource.ctrl_cpu
    warn_temp = new_resource.warn_temp
    disk = new_resource.disk
    conn_type3 = new_resource.conn_type3
    conn_type2 = new_resource.conn_type2
    memory = new_resource.memory
    smp_type2 = new_resource.smp_type2
    smp_type3 = new_resource.smp_type3
    conn_type1 = new_resource.conn_type1
    conn_type0 = new_resource.conn_type0
    smp_type0 = new_resource.smp_type0
    smp_type4 = new_resource.smp_type4
    conn_type4 = new_resource.conn_type4

    params = { "monitor": {"data-cpu": data_cpu,
        "smp-type1": smp_type1,
        "buffer-usage": buffer_usage,
        "uuid": uuid,
        "buffer-drop": buffer_drop,
        "ctrl-cpu": ctrl_cpu,
        "warn-temp": warn_temp,
        "disk": disk,
        "conn-type3": conn_type3,
        "conn-type2": conn_type2,
        "memory": memory,
        "smp-type2": smp_type2,
        "smp-type3": smp_type3,
        "conn-type1": conn_type1,
        "conn-type0": conn_type0,
        "smp-type0": smp_type0,
        "smp-type4": smp_type4,
        "conn-type4": conn_type4,} }

    params[:"monitor"].each do |k, v|
        if not v 
            params[:"monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/monitor"
    data_cpu = new_resource.data_cpu
    smp_type1 = new_resource.smp_type1
    buffer_usage = new_resource.buffer_usage
    uuid = new_resource.uuid
    buffer_drop = new_resource.buffer_drop
    ctrl_cpu = new_resource.ctrl_cpu
    warn_temp = new_resource.warn_temp
    disk = new_resource.disk
    conn_type3 = new_resource.conn_type3
    conn_type2 = new_resource.conn_type2
    memory = new_resource.memory
    smp_type2 = new_resource.smp_type2
    smp_type3 = new_resource.smp_type3
    conn_type1 = new_resource.conn_type1
    conn_type0 = new_resource.conn_type0
    smp_type0 = new_resource.smp_type0
    smp_type4 = new_resource.smp_type4
    conn_type4 = new_resource.conn_type4

    params = { "monitor": {"data-cpu": data_cpu,
        "smp-type1": smp_type1,
        "buffer-usage": buffer_usage,
        "uuid": uuid,
        "buffer-drop": buffer_drop,
        "ctrl-cpu": ctrl_cpu,
        "warn-temp": warn_temp,
        "disk": disk,
        "conn-type3": conn_type3,
        "conn-type2": conn_type2,
        "memory": memory,
        "smp-type2": smp_type2,
        "smp-type3": smp_type3,
        "conn-type1": conn_type1,
        "conn-type0": conn_type0,
        "smp-type0": smp_type0,
        "smp-type4": smp_type4,
        "conn-type4": conn_type4,} }

    params[:"monitor"].each do |k, v|
        if not v
            params[:"monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["monitor"].each do |k, v|
        if v != params[:"monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/monitor"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end