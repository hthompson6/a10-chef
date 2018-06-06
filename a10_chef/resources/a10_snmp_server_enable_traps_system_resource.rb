resource_name :a10_snmp_server_enable_traps_system

property :a10_name, String, name_property: true
property :all, [true, false]
property :data_cpu_high, [true, false]
property :uuid, String
property :power, [true, false]
property :high_disk_use, [true, false]
property :high_memory_use, [true, false]
property :control_cpu_high, [true, false]
property :file_sys_read_only, [true, false]
property :low_temp, [true, false]
property :high_temp, [true, false]
property :sec_disk, [true, false]
property :start, [true, false]
property :fan, [true, false]
property :shutdown, [true, false]
property :pri_disk, [true, false]
property :license_management, [true, false]
property :packet_drop, [true, false]
property :restart, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/"
    get_url = "/axapi/v3/snmp-server/enable/traps/system"
    all = new_resource.all
    data_cpu_high = new_resource.data_cpu_high
    uuid = new_resource.uuid
    power = new_resource.power
    high_disk_use = new_resource.high_disk_use
    high_memory_use = new_resource.high_memory_use
    control_cpu_high = new_resource.control_cpu_high
    file_sys_read_only = new_resource.file_sys_read_only
    low_temp = new_resource.low_temp
    high_temp = new_resource.high_temp
    sec_disk = new_resource.sec_disk
    start = new_resource.start
    fan = new_resource.fan
    shutdown = new_resource.shutdown
    pri_disk = new_resource.pri_disk
    license_management = new_resource.license_management
    packet_drop = new_resource.packet_drop
    restart = new_resource.restart

    params = { "system": {"all": all,
        "data-cpu-high": data_cpu_high,
        "uuid": uuid,
        "power": power,
        "high-disk-use": high_disk_use,
        "high-memory-use": high_memory_use,
        "control-cpu-high": control_cpu_high,
        "file-sys-read-only": file_sys_read_only,
        "low-temp": low_temp,
        "high-temp": high_temp,
        "sec-disk": sec_disk,
        "start": start,
        "fan": fan,
        "shutdown": shutdown,
        "pri-disk": pri_disk,
        "license-management": license_management,
        "packet-drop": packet_drop,
        "restart": restart,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/system"
    all = new_resource.all
    data_cpu_high = new_resource.data_cpu_high
    uuid = new_resource.uuid
    power = new_resource.power
    high_disk_use = new_resource.high_disk_use
    high_memory_use = new_resource.high_memory_use
    control_cpu_high = new_resource.control_cpu_high
    file_sys_read_only = new_resource.file_sys_read_only
    low_temp = new_resource.low_temp
    high_temp = new_resource.high_temp
    sec_disk = new_resource.sec_disk
    start = new_resource.start
    fan = new_resource.fan
    shutdown = new_resource.shutdown
    pri_disk = new_resource.pri_disk
    license_management = new_resource.license_management
    packet_drop = new_resource.packet_drop
    restart = new_resource.restart

    params = { "system": {"all": all,
        "data-cpu-high": data_cpu_high,
        "uuid": uuid,
        "power": power,
        "high-disk-use": high_disk_use,
        "high-memory-use": high_memory_use,
        "control-cpu-high": control_cpu_high,
        "file-sys-read-only": file_sys_read_only,
        "low-temp": low_temp,
        "high-temp": high_temp,
        "sec-disk": sec_disk,
        "start": start,
        "fan": fan,
        "shutdown": shutdown,
        "pri-disk": pri_disk,
        "license-management": license_management,
        "packet-drop": packet_drop,
        "restart": restart,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/system"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system') do
            client.delete(url)
        end
    end
end