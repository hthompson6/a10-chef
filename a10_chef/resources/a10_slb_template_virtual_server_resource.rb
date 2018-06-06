resource_name :a10_slb_template_virtual_server

property :a10_name, String, name_property: true
property :conn_limit, Integer
property :conn_rate_limit_no_logging, [true, false]
property :icmp_lockup_period, Integer
property :conn_limit_reset, [true, false]
property :rate_interval, ['100ms','second']
property :user_tag, String
property :icmpv6_rate_limit, Integer
property :subnet_gratuitous_arp, [true, false]
property :icmpv6_lockup, Integer
property :conn_rate_limit_reset, [true, false]
property :tcp_stack_tfo_backoff_time, Integer
property :tcp_stack_tfo_cookie_time_limit, Integer
property :conn_limit_no_logging, [true, false]
property :icmpv6_lockup_period, Integer
property :conn_rate_limit, Integer
property :tcp_stack_tfo_active_conn_limit, Integer
property :icmp_lockup, Integer
property :icmp_rate_limit, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/virtual-server/"
    get_url = "/axapi/v3/slb/template/virtual-server/%<name>s"
    conn_limit = new_resource.conn_limit
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    icmp_lockup_period = new_resource.icmp_lockup_period
    conn_limit_reset = new_resource.conn_limit_reset
    rate_interval = new_resource.rate_interval
    user_tag = new_resource.user_tag
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    subnet_gratuitous_arp = new_resource.subnet_gratuitous_arp
    icmpv6_lockup = new_resource.icmpv6_lockup
    conn_rate_limit_reset = new_resource.conn_rate_limit_reset
    tcp_stack_tfo_backoff_time = new_resource.tcp_stack_tfo_backoff_time
    tcp_stack_tfo_cookie_time_limit = new_resource.tcp_stack_tfo_cookie_time_limit
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    icmpv6_lockup_period = new_resource.icmpv6_lockup_period
    conn_rate_limit = new_resource.conn_rate_limit
    tcp_stack_tfo_active_conn_limit = new_resource.tcp_stack_tfo_active_conn_limit
    icmp_lockup = new_resource.icmp_lockup
    icmp_rate_limit = new_resource.icmp_rate_limit
    uuid = new_resource.uuid

    params = { "virtual-server": {"conn-limit": conn_limit,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "icmp-lockup-period": icmp_lockup_period,
        "conn-limit-reset": conn_limit_reset,
        "rate-interval": rate_interval,
        "user-tag": user_tag,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "subnet-gratuitous-arp": subnet_gratuitous_arp,
        "icmpv6-lockup": icmpv6_lockup,
        "conn-rate-limit-reset": conn_rate_limit_reset,
        "tcp-stack-tfo-backoff-time": tcp_stack_tfo_backoff_time,
        "tcp-stack-tfo-cookie-time-limit": tcp_stack_tfo_cookie_time_limit,
        "conn-limit-no-logging": conn_limit_no_logging,
        "icmpv6-lockup-period": icmpv6_lockup_period,
        "conn-rate-limit": conn_rate_limit,
        "tcp-stack-tfo-active-conn-limit": tcp_stack_tfo_active_conn_limit,
        "icmp-lockup": icmp_lockup,
        "icmp-rate-limit": icmp_rate_limit,
        "uuid": uuid,} }

    params[:"virtual-server"].each do |k, v|
        if not v 
            params[:"virtual-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating virtual-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/virtual-server/%<name>s"
    conn_limit = new_resource.conn_limit
    conn_rate_limit_no_logging = new_resource.conn_rate_limit_no_logging
    a10_name = new_resource.a10_name
    icmp_lockup_period = new_resource.icmp_lockup_period
    conn_limit_reset = new_resource.conn_limit_reset
    rate_interval = new_resource.rate_interval
    user_tag = new_resource.user_tag
    icmpv6_rate_limit = new_resource.icmpv6_rate_limit
    subnet_gratuitous_arp = new_resource.subnet_gratuitous_arp
    icmpv6_lockup = new_resource.icmpv6_lockup
    conn_rate_limit_reset = new_resource.conn_rate_limit_reset
    tcp_stack_tfo_backoff_time = new_resource.tcp_stack_tfo_backoff_time
    tcp_stack_tfo_cookie_time_limit = new_resource.tcp_stack_tfo_cookie_time_limit
    conn_limit_no_logging = new_resource.conn_limit_no_logging
    icmpv6_lockup_period = new_resource.icmpv6_lockup_period
    conn_rate_limit = new_resource.conn_rate_limit
    tcp_stack_tfo_active_conn_limit = new_resource.tcp_stack_tfo_active_conn_limit
    icmp_lockup = new_resource.icmp_lockup
    icmp_rate_limit = new_resource.icmp_rate_limit
    uuid = new_resource.uuid

    params = { "virtual-server": {"conn-limit": conn_limit,
        "conn-rate-limit-no-logging": conn_rate_limit_no_logging,
        "name": a10_name,
        "icmp-lockup-period": icmp_lockup_period,
        "conn-limit-reset": conn_limit_reset,
        "rate-interval": rate_interval,
        "user-tag": user_tag,
        "icmpv6-rate-limit": icmpv6_rate_limit,
        "subnet-gratuitous-arp": subnet_gratuitous_arp,
        "icmpv6-lockup": icmpv6_lockup,
        "conn-rate-limit-reset": conn_rate_limit_reset,
        "tcp-stack-tfo-backoff-time": tcp_stack_tfo_backoff_time,
        "tcp-stack-tfo-cookie-time-limit": tcp_stack_tfo_cookie_time_limit,
        "conn-limit-no-logging": conn_limit_no_logging,
        "icmpv6-lockup-period": icmpv6_lockup_period,
        "conn-rate-limit": conn_rate_limit,
        "tcp-stack-tfo-active-conn-limit": tcp_stack_tfo_active_conn_limit,
        "icmp-lockup": icmp_lockup,
        "icmp-rate-limit": icmp_rate_limit,
        "uuid": uuid,} }

    params[:"virtual-server"].each do |k, v|
        if not v
            params[:"virtual-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["virtual-server"].each do |k, v|
        if v != params[:"virtual-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating virtual-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/virtual-server/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting virtual-server') do
            client.delete(url)
        end
    end
end