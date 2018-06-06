resource_name :a10_vpn

property :a10_name, String, name_property: true
property :jumbo_fragment, [true, false]
property :uuid, String
property :asymmetric_flow_support, [true, false]
property :tcp_mss_adjust_disable, [true, false]
property :ike_stats_global, Hash
property :fragment_after_encap, [true, false]
property :ipsec_error_dump, [true, false]
property :sampling_enable, Array
property :stateful_mode, [true, false]
property :ike_sa_timeout, Integer
property :error, Hash
property :nat_traversal_flow_affinity, [true, false]
property :ike_gateway_list, Array
property :ipsec_list, Array
property :revocation_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/vpn"
    jumbo_fragment = new_resource.jumbo_fragment
    uuid = new_resource.uuid
    asymmetric_flow_support = new_resource.asymmetric_flow_support
    tcp_mss_adjust_disable = new_resource.tcp_mss_adjust_disable
    ike_stats_global = new_resource.ike_stats_global
    fragment_after_encap = new_resource.fragment_after_encap
    ipsec_error_dump = new_resource.ipsec_error_dump
    sampling_enable = new_resource.sampling_enable
    stateful_mode = new_resource.stateful_mode
    ike_sa_timeout = new_resource.ike_sa_timeout
    error = new_resource.error
    nat_traversal_flow_affinity = new_resource.nat_traversal_flow_affinity
    ike_gateway_list = new_resource.ike_gateway_list
    ipsec_list = new_resource.ipsec_list
    revocation_list = new_resource.revocation_list

    params = { "vpn": {"jumbo-fragment": jumbo_fragment,
        "uuid": uuid,
        "asymmetric-flow-support": asymmetric_flow_support,
        "tcp-mss-adjust-disable": tcp_mss_adjust_disable,
        "ike-stats-global": ike_stats_global,
        "fragment-after-encap": fragment_after_encap,
        "ipsec-error-dump": ipsec_error_dump,
        "sampling-enable": sampling_enable,
        "stateful-mode": stateful_mode,
        "ike-sa-timeout": ike_sa_timeout,
        "error": error,
        "nat-traversal-flow-affinity": nat_traversal_flow_affinity,
        "ike-gateway-list": ike_gateway_list,
        "ipsec-list": ipsec_list,
        "revocation-list": revocation_list,} }

    params[:"vpn"].each do |k, v|
        if not v 
            params[:"vpn"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vpn') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn"
    jumbo_fragment = new_resource.jumbo_fragment
    uuid = new_resource.uuid
    asymmetric_flow_support = new_resource.asymmetric_flow_support
    tcp_mss_adjust_disable = new_resource.tcp_mss_adjust_disable
    ike_stats_global = new_resource.ike_stats_global
    fragment_after_encap = new_resource.fragment_after_encap
    ipsec_error_dump = new_resource.ipsec_error_dump
    sampling_enable = new_resource.sampling_enable
    stateful_mode = new_resource.stateful_mode
    ike_sa_timeout = new_resource.ike_sa_timeout
    error = new_resource.error
    nat_traversal_flow_affinity = new_resource.nat_traversal_flow_affinity
    ike_gateway_list = new_resource.ike_gateway_list
    ipsec_list = new_resource.ipsec_list
    revocation_list = new_resource.revocation_list

    params = { "vpn": {"jumbo-fragment": jumbo_fragment,
        "uuid": uuid,
        "asymmetric-flow-support": asymmetric_flow_support,
        "tcp-mss-adjust-disable": tcp_mss_adjust_disable,
        "ike-stats-global": ike_stats_global,
        "fragment-after-encap": fragment_after_encap,
        "ipsec-error-dump": ipsec_error_dump,
        "sampling-enable": sampling_enable,
        "stateful-mode": stateful_mode,
        "ike-sa-timeout": ike_sa_timeout,
        "error": error,
        "nat-traversal-flow-affinity": nat_traversal_flow_affinity,
        "ike-gateway-list": ike_gateway_list,
        "ipsec-list": ipsec_list,
        "revocation-list": revocation_list,} }

    params[:"vpn"].each do |k, v|
        if not v
            params[:"vpn"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vpn"].each do |k, v|
        if v != params[:"vpn"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vpn') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vpn') do
            client.delete(url)
        end
    end
end