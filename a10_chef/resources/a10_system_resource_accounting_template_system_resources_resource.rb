resource_name :a10_system_resource_accounting_template_system_resources

property :a10_name, String, name_property: true
property :l4_session_limit_cfg, Hash
property :l7cps_limit_cfg, Hash
property :l4cps_limit_cfg, Hash
property :uuid, String
property :natcps_limit_cfg, Hash
property :sslcps_limit_cfg, Hash
property :fwcps_limit_cfg, Hash
property :ssl_throughput_limit_cfg, Hash
property :threshold, Integer
property :bw_limit_cfg, Hash
property :concurrent_session_limit_cfg, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/resource-accounting/template/%<name>s/"
    get_url = "/axapi/v3/system/resource-accounting/template/%<name>s/system-resources"
    l4_session_limit_cfg = new_resource.l4_session_limit_cfg
    l7cps_limit_cfg = new_resource.l7cps_limit_cfg
    l4cps_limit_cfg = new_resource.l4cps_limit_cfg
    uuid = new_resource.uuid
    natcps_limit_cfg = new_resource.natcps_limit_cfg
    sslcps_limit_cfg = new_resource.sslcps_limit_cfg
    fwcps_limit_cfg = new_resource.fwcps_limit_cfg
    ssl_throughput_limit_cfg = new_resource.ssl_throughput_limit_cfg
    threshold = new_resource.threshold
    bw_limit_cfg = new_resource.bw_limit_cfg
    concurrent_session_limit_cfg = new_resource.concurrent_session_limit_cfg

    params = { "system-resources": {"l4-session-limit-cfg": l4_session_limit_cfg,
        "l7cps-limit-cfg": l7cps_limit_cfg,
        "l4cps-limit-cfg": l4cps_limit_cfg,
        "uuid": uuid,
        "natcps-limit-cfg": natcps_limit_cfg,
        "sslcps-limit-cfg": sslcps_limit_cfg,
        "fwcps-limit-cfg": fwcps_limit_cfg,
        "ssl-throughput-limit-cfg": ssl_throughput_limit_cfg,
        "threshold": threshold,
        "bw-limit-cfg": bw_limit_cfg,
        "concurrent-session-limit-cfg": concurrent_session_limit_cfg,} }

    params[:"system-resources"].each do |k, v|
        if not v 
            params[:"system-resources"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating system-resources') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/system-resources"
    l4_session_limit_cfg = new_resource.l4_session_limit_cfg
    l7cps_limit_cfg = new_resource.l7cps_limit_cfg
    l4cps_limit_cfg = new_resource.l4cps_limit_cfg
    uuid = new_resource.uuid
    natcps_limit_cfg = new_resource.natcps_limit_cfg
    sslcps_limit_cfg = new_resource.sslcps_limit_cfg
    fwcps_limit_cfg = new_resource.fwcps_limit_cfg
    ssl_throughput_limit_cfg = new_resource.ssl_throughput_limit_cfg
    threshold = new_resource.threshold
    bw_limit_cfg = new_resource.bw_limit_cfg
    concurrent_session_limit_cfg = new_resource.concurrent_session_limit_cfg

    params = { "system-resources": {"l4-session-limit-cfg": l4_session_limit_cfg,
        "l7cps-limit-cfg": l7cps_limit_cfg,
        "l4cps-limit-cfg": l4cps_limit_cfg,
        "uuid": uuid,
        "natcps-limit-cfg": natcps_limit_cfg,
        "sslcps-limit-cfg": sslcps_limit_cfg,
        "fwcps-limit-cfg": fwcps_limit_cfg,
        "ssl-throughput-limit-cfg": ssl_throughput_limit_cfg,
        "threshold": threshold,
        "bw-limit-cfg": bw_limit_cfg,
        "concurrent-session-limit-cfg": concurrent_session_limit_cfg,} }

    params[:"system-resources"].each do |k, v|
        if not v
            params[:"system-resources"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["system-resources"].each do |k, v|
        if v != params[:"system-resources"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating system-resources') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s/system-resources"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting system-resources') do
            client.delete(url)
        end
    end
end