resource_name :a10_fail_safe

property :a10_name, String, name_property: true
property :session_mem_recovery_threshold, Integer
property :log, [true, false]
property :fpga_buff_recovery_threshold, Integer
property :hw_error_monitor, ['hw-error-monitor-disable','hw-error-monitor-enable']
property :hw_error_recovery_timeout, Integer
property :sw_error_monitor_enable, [true, false]
property :disable_failsafe, Hash
property :kill, [true, false]
property :total_memory_size_check, Integer
property :sw_error_recovery_timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/fail-safe"
    session_mem_recovery_threshold = new_resource.session_mem_recovery_threshold
    log = new_resource.log
    fpga_buff_recovery_threshold = new_resource.fpga_buff_recovery_threshold
    hw_error_monitor = new_resource.hw_error_monitor
    hw_error_recovery_timeout = new_resource.hw_error_recovery_timeout
    sw_error_monitor_enable = new_resource.sw_error_monitor_enable
    disable_failsafe = new_resource.disable_failsafe
    kill = new_resource.kill
    total_memory_size_check = new_resource.total_memory_size_check
    sw_error_recovery_timeout = new_resource.sw_error_recovery_timeout
    uuid = new_resource.uuid

    params = { "fail-safe": {"session-mem-recovery-threshold": session_mem_recovery_threshold,
        "log": log,
        "fpga-buff-recovery-threshold": fpga_buff_recovery_threshold,
        "hw-error-monitor": hw_error_monitor,
        "hw-error-recovery-timeout": hw_error_recovery_timeout,
        "sw-error-monitor-enable": sw_error_monitor_enable,
        "disable-failsafe": disable_failsafe,
        "kill": kill,
        "total-memory-size-check": total_memory_size_check,
        "sw-error-recovery-timeout": sw_error_recovery_timeout,
        "uuid": uuid,} }

    params[:"fail-safe"].each do |k, v|
        if not v 
            params[:"fail-safe"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating fail-safe') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fail-safe"
    session_mem_recovery_threshold = new_resource.session_mem_recovery_threshold
    log = new_resource.log
    fpga_buff_recovery_threshold = new_resource.fpga_buff_recovery_threshold
    hw_error_monitor = new_resource.hw_error_monitor
    hw_error_recovery_timeout = new_resource.hw_error_recovery_timeout
    sw_error_monitor_enable = new_resource.sw_error_monitor_enable
    disable_failsafe = new_resource.disable_failsafe
    kill = new_resource.kill
    total_memory_size_check = new_resource.total_memory_size_check
    sw_error_recovery_timeout = new_resource.sw_error_recovery_timeout
    uuid = new_resource.uuid

    params = { "fail-safe": {"session-mem-recovery-threshold": session_mem_recovery_threshold,
        "log": log,
        "fpga-buff-recovery-threshold": fpga_buff_recovery_threshold,
        "hw-error-monitor": hw_error_monitor,
        "hw-error-recovery-timeout": hw_error_recovery_timeout,
        "sw-error-monitor-enable": sw_error_monitor_enable,
        "disable-failsafe": disable_failsafe,
        "kill": kill,
        "total-memory-size-check": total_memory_size_check,
        "sw-error-recovery-timeout": sw_error_recovery_timeout,
        "uuid": uuid,} }

    params[:"fail-safe"].each do |k, v|
        if not v
            params[:"fail-safe"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["fail-safe"].each do |k, v|
        if v != params[:"fail-safe"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating fail-safe') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fail-safe"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting fail-safe') do
            client.delete(url)
        end
    end
end