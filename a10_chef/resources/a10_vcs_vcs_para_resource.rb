resource_name :a10_vcs_vcs_para

property :a10_name, String, name_property: true
property :multicast_port, Integer
property :dead_interval, Integer
property :forever, [true, false]
property :ssl_enable, [true, false]
property :uuid, String
property :multicast_ip, String
property :multicast_ipv6, String
property :force_wait_interval, Integer
property :floating_ip_cfg, Array
property :failure_retry_count_value, Integer
property :time_interval, Integer
property :config_seq, String
property :floating_ipv6_cfg, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/"
    get_url = "/axapi/v3/vcs/vcs-para"
    multicast_port = new_resource.multicast_port
    dead_interval = new_resource.dead_interval
    forever = new_resource.forever
    ssl_enable = new_resource.ssl_enable
    uuid = new_resource.uuid
    multicast_ip = new_resource.multicast_ip
    multicast_ipv6 = new_resource.multicast_ipv6
    force_wait_interval = new_resource.force_wait_interval
    floating_ip_cfg = new_resource.floating_ip_cfg
    failure_retry_count_value = new_resource.failure_retry_count_value
    time_interval = new_resource.time_interval
    config_seq = new_resource.config_seq
    floating_ipv6_cfg = new_resource.floating_ipv6_cfg

    params = { "vcs-para": {"multicast-port": multicast_port,
        "dead-interval": dead_interval,
        "forever": forever,
        "ssl-enable": ssl_enable,
        "uuid": uuid,
        "multicast-ip": multicast_ip,
        "multicast-ipv6": multicast_ipv6,
        "force-wait-interval": force_wait_interval,
        "floating-ip-cfg": floating_ip_cfg,
        "failure-retry-count-value": failure_retry_count_value,
        "time-interval": time_interval,
        "config-seq": config_seq,
        "floating-ipv6-cfg": floating_ipv6_cfg,} }

    params[:"vcs-para"].each do |k, v|
        if not v 
            params[:"vcs-para"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vcs-para') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vcs-para"
    multicast_port = new_resource.multicast_port
    dead_interval = new_resource.dead_interval
    forever = new_resource.forever
    ssl_enable = new_resource.ssl_enable
    uuid = new_resource.uuid
    multicast_ip = new_resource.multicast_ip
    multicast_ipv6 = new_resource.multicast_ipv6
    force_wait_interval = new_resource.force_wait_interval
    floating_ip_cfg = new_resource.floating_ip_cfg
    failure_retry_count_value = new_resource.failure_retry_count_value
    time_interval = new_resource.time_interval
    config_seq = new_resource.config_seq
    floating_ipv6_cfg = new_resource.floating_ipv6_cfg

    params = { "vcs-para": {"multicast-port": multicast_port,
        "dead-interval": dead_interval,
        "forever": forever,
        "ssl-enable": ssl_enable,
        "uuid": uuid,
        "multicast-ip": multicast_ip,
        "multicast-ipv6": multicast_ipv6,
        "force-wait-interval": force_wait_interval,
        "floating-ip-cfg": floating_ip_cfg,
        "failure-retry-count-value": failure_retry_count_value,
        "time-interval": time_interval,
        "config-seq": config_seq,
        "floating-ipv6-cfg": floating_ipv6_cfg,} }

    params[:"vcs-para"].each do |k, v|
        if not v
            params[:"vcs-para"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vcs-para"].each do |k, v|
        if v != params[:"vcs-para"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vcs-para') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/vcs-para"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vcs-para') do
            client.delete(url)
        end
    end
end