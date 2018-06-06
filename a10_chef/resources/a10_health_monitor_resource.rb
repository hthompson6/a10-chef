resource_name :a10_health_monitor

property :a10_name, String, name_property: true
property :override_ipv4, String
property :override_ipv6, String
property :uuid, String
property :ssl_ciphers, String
property :strict_retry_on_server_err_resp, [true, false]
property :passive_interval, Integer
property :override_port, Integer
property :up_retry, Integer
property :interval, Integer
property :sample_threshold, Integer
property :a10_retry, Integer
property :user_tag, String
property :timeout, Integer
property :passive, [true, false]
property :threshold, Integer
property :dsr_l2_strict, [true, false]
property :status_code, ['status-code-2xx','status-code-non-5xx']
property :disable_after_down, [true, false]
property :a10_method, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/"
    get_url = "/axapi/v3/health/monitor/%<name>s"
    override_ipv4 = new_resource.override_ipv4
    override_ipv6 = new_resource.override_ipv6
    uuid = new_resource.uuid
    ssl_ciphers = new_resource.ssl_ciphers
    strict_retry_on_server_err_resp = new_resource.strict_retry_on_server_err_resp
    passive_interval = new_resource.passive_interval
    override_port = new_resource.override_port
    up_retry = new_resource.up_retry
    interval = new_resource.interval
    sample_threshold = new_resource.sample_threshold
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    timeout = new_resource.timeout
    passive = new_resource.passive
    threshold = new_resource.threshold
    dsr_l2_strict = new_resource.dsr_l2_strict
    status_code = new_resource.status_code
    disable_after_down = new_resource.disable_after_down
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name

    params = { "monitor": {"override-ipv4": override_ipv4,
        "override-ipv6": override_ipv6,
        "uuid": uuid,
        "ssl-ciphers": ssl_ciphers,
        "strict-retry-on-server-err-resp": strict_retry_on_server_err_resp,
        "passive-interval": passive_interval,
        "override-port": override_port,
        "up-retry": up_retry,
        "interval": interval,
        "sample-threshold": sample_threshold,
        "retry": a10_retry,
        "user-tag": user_tag,
        "timeout": timeout,
        "passive": passive,
        "threshold": threshold,
        "dsr-l2-strict": dsr_l2_strict,
        "status-code": status_code,
        "disable-after-down": disable_after_down,
        "method": a10_method,
        "name": a10_name,} }

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
    url = "/axapi/v3/health/monitor/%<name>s"
    override_ipv4 = new_resource.override_ipv4
    override_ipv6 = new_resource.override_ipv6
    uuid = new_resource.uuid
    ssl_ciphers = new_resource.ssl_ciphers
    strict_retry_on_server_err_resp = new_resource.strict_retry_on_server_err_resp
    passive_interval = new_resource.passive_interval
    override_port = new_resource.override_port
    up_retry = new_resource.up_retry
    interval = new_resource.interval
    sample_threshold = new_resource.sample_threshold
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    timeout = new_resource.timeout
    passive = new_resource.passive
    threshold = new_resource.threshold
    dsr_l2_strict = new_resource.dsr_l2_strict
    status_code = new_resource.status_code
    disable_after_down = new_resource.disable_after_down
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name

    params = { "monitor": {"override-ipv4": override_ipv4,
        "override-ipv6": override_ipv6,
        "uuid": uuid,
        "ssl-ciphers": ssl_ciphers,
        "strict-retry-on-server-err-resp": strict_retry_on_server_err_resp,
        "passive-interval": passive_interval,
        "override-port": override_port,
        "up-retry": up_retry,
        "interval": interval,
        "sample-threshold": sample_threshold,
        "retry": a10_retry,
        "user-tag": user_tag,
        "timeout": timeout,
        "passive": passive,
        "threshold": threshold,
        "dsr-l2-strict": dsr_l2_strict,
        "status-code": status_code,
        "disable-after-down": disable_after_down,
        "method": a10_method,
        "name": a10_name,} }

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
    url = "/axapi/v3/health/monitor/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end