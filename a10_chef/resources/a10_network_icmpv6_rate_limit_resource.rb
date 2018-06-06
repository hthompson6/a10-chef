resource_name :a10_network_icmpv6_rate_limit

property :a10_name, String, name_property: true
property :icmpv6_lockup_period, Integer
property :icmpv6_lockup, Integer
property :uuid, String
property :icmpv6_normal_rate_limit, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/icmpv6-rate-limit"
    icmpv6_lockup_period = new_resource.icmpv6_lockup_period
    icmpv6_lockup = new_resource.icmpv6_lockup
    uuid = new_resource.uuid
    icmpv6_normal_rate_limit = new_resource.icmpv6_normal_rate_limit

    params = { "icmpv6-rate-limit": {"icmpv6-lockup-period": icmpv6_lockup_period,
        "icmpv6-lockup": icmpv6_lockup,
        "uuid": uuid,
        "icmpv6-normal-rate-limit": icmpv6_normal_rate_limit,} }

    params[:"icmpv6-rate-limit"].each do |k, v|
        if not v 
            params[:"icmpv6-rate-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating icmpv6-rate-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/icmpv6-rate-limit"
    icmpv6_lockup_period = new_resource.icmpv6_lockup_period
    icmpv6_lockup = new_resource.icmpv6_lockup
    uuid = new_resource.uuid
    icmpv6_normal_rate_limit = new_resource.icmpv6_normal_rate_limit

    params = { "icmpv6-rate-limit": {"icmpv6-lockup-period": icmpv6_lockup_period,
        "icmpv6-lockup": icmpv6_lockup,
        "uuid": uuid,
        "icmpv6-normal-rate-limit": icmpv6_normal_rate_limit,} }

    params[:"icmpv6-rate-limit"].each do |k, v|
        if not v
            params[:"icmpv6-rate-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["icmpv6-rate-limit"].each do |k, v|
        if v != params[:"icmpv6-rate-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating icmpv6-rate-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/icmpv6-rate-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting icmpv6-rate-limit') do
            client.delete(url)
        end
    end
end