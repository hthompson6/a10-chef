resource_name :a10_cgnv6_translation

property :a10_name, String, name_property: true
property :tcp_timeout, Integer
property :udp_timeout, Integer
property :service_timeout_list, Array
property :icmp_timeout, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/translation"
    tcp_timeout = new_resource.tcp_timeout
    udp_timeout = new_resource.udp_timeout
    service_timeout_list = new_resource.service_timeout_list
    icmp_timeout = new_resource.icmp_timeout
    uuid = new_resource.uuid

    params = { "translation": {"tcp-timeout": tcp_timeout,
        "udp-timeout": udp_timeout,
        "service-timeout-list": service_timeout_list,
        "icmp-timeout": icmp_timeout,
        "uuid": uuid,} }

    params[:"translation"].each do |k, v|
        if not v 
            params[:"translation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating translation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/translation"
    tcp_timeout = new_resource.tcp_timeout
    udp_timeout = new_resource.udp_timeout
    service_timeout_list = new_resource.service_timeout_list
    icmp_timeout = new_resource.icmp_timeout
    uuid = new_resource.uuid

    params = { "translation": {"tcp-timeout": tcp_timeout,
        "udp-timeout": udp_timeout,
        "service-timeout-list": service_timeout_list,
        "icmp-timeout": icmp_timeout,
        "uuid": uuid,} }

    params[:"translation"].each do |k, v|
        if not v
            params[:"translation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["translation"].each do |k, v|
        if v != params[:"translation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating translation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/translation"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting translation') do
            client.delete(url)
        end
    end
end