resource_name :a10_cgnv6_lsn_global

property :a10_name, String, name_property: true
property :logging, Hash
property :uuid, String
property :inbound_refresh, ['disable']
property :hairpinning, ['filter-none','filter-self-ip','filter-self-ip-port']
property :port_batching, Hash
property :half_close_timeout, Integer
property :attempt_port_preservation, ['disable']
property :ip_selection, ['random','round-robin','least-used-strict','least-udp-used-strict','least-tcp-used-strict','least-reserved-strict','least-udp-reserved-strict','least-tcp-reserved-strict','least-users-strict']
property :syn_timeout, Integer
property :icmp, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/"
    get_url = "/axapi/v3/cgnv6/lsn/global"
    logging = new_resource.logging
    uuid = new_resource.uuid
    inbound_refresh = new_resource.inbound_refresh
    hairpinning = new_resource.hairpinning
    port_batching = new_resource.port_batching
    half_close_timeout = new_resource.half_close_timeout
    attempt_port_preservation = new_resource.attempt_port_preservation
    ip_selection = new_resource.ip_selection
    syn_timeout = new_resource.syn_timeout
    icmp = new_resource.icmp

    params = { "global": {"logging": logging,
        "uuid": uuid,
        "inbound-refresh": inbound_refresh,
        "hairpinning": hairpinning,
        "port-batching": port_batching,
        "half-close-timeout": half_close_timeout,
        "attempt-port-preservation": attempt_port_preservation,
        "ip-selection": ip_selection,
        "syn-timeout": syn_timeout,
        "icmp": icmp,} }

    params[:"global"].each do |k, v|
        if not v 
            params[:"global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/global"
    logging = new_resource.logging
    uuid = new_resource.uuid
    inbound_refresh = new_resource.inbound_refresh
    hairpinning = new_resource.hairpinning
    port_batching = new_resource.port_batching
    half_close_timeout = new_resource.half_close_timeout
    attempt_port_preservation = new_resource.attempt_port_preservation
    ip_selection = new_resource.ip_selection
    syn_timeout = new_resource.syn_timeout
    icmp = new_resource.icmp

    params = { "global": {"logging": logging,
        "uuid": uuid,
        "inbound-refresh": inbound_refresh,
        "hairpinning": hairpinning,
        "port-batching": port_batching,
        "half-close-timeout": half_close_timeout,
        "attempt-port-preservation": attempt_port_preservation,
        "ip-selection": ip_selection,
        "syn-timeout": syn_timeout,
        "icmp": icmp,} }

    params[:"global"].each do |k, v|
        if not v
            params[:"global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["global"].each do |k, v|
        if v != params[:"global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting global') do
            client.delete(url)
        end
    end
end