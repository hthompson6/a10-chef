resource_name :a10_network_icmp_rate_limit

property :a10_name, String, name_property: true
property :icmp_normal_rate_limit, Integer
property :icmp_lockup, Integer
property :icmp_lockup_period, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/icmp-rate-limit"
    icmp_normal_rate_limit = new_resource.icmp_normal_rate_limit
    icmp_lockup = new_resource.icmp_lockup
    icmp_lockup_period = new_resource.icmp_lockup_period
    uuid = new_resource.uuid

    params = { "icmp-rate-limit": {"icmp-normal-rate-limit": icmp_normal_rate_limit,
        "icmp-lockup": icmp_lockup,
        "icmp-lockup-period": icmp_lockup_period,
        "uuid": uuid,} }

    params[:"icmp-rate-limit"].each do |k, v|
        if not v 
            params[:"icmp-rate-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating icmp-rate-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/icmp-rate-limit"
    icmp_normal_rate_limit = new_resource.icmp_normal_rate_limit
    icmp_lockup = new_resource.icmp_lockup
    icmp_lockup_period = new_resource.icmp_lockup_period
    uuid = new_resource.uuid

    params = { "icmp-rate-limit": {"icmp-normal-rate-limit": icmp_normal_rate_limit,
        "icmp-lockup": icmp_lockup,
        "icmp-lockup-period": icmp_lockup_period,
        "uuid": uuid,} }

    params[:"icmp-rate-limit"].each do |k, v|
        if not v
            params[:"icmp-rate-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["icmp-rate-limit"].each do |k, v|
        if v != params[:"icmp-rate-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating icmp-rate-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/icmp-rate-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting icmp-rate-limit') do
            client.delete(url)
        end
    end
end