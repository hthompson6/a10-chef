resource_name :a10_ip_nat_translation

property :a10_name, String, name_property: true
property :uuid, String
property :tcp_timeout, Integer
property :service_timeout_list, Array
property :ignore_tcp_msl, [true, false]
property :icmp_timeout, Hash
property :udp_timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/"
    get_url = "/axapi/v3/ip/nat/translation"
    uuid = new_resource.uuid
    tcp_timeout = new_resource.tcp_timeout
    service_timeout_list = new_resource.service_timeout_list
    ignore_tcp_msl = new_resource.ignore_tcp_msl
    icmp_timeout = new_resource.icmp_timeout
    udp_timeout = new_resource.udp_timeout

    params = { "translation": {"uuid": uuid,
        "tcp-timeout": tcp_timeout,
        "service-timeout-list": service_timeout_list,
        "ignore-tcp-msl": ignore_tcp_msl,
        "icmp-timeout": icmp_timeout,
        "udp-timeout": udp_timeout,} }

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
    url = "/axapi/v3/ip/nat/translation"
    uuid = new_resource.uuid
    tcp_timeout = new_resource.tcp_timeout
    service_timeout_list = new_resource.service_timeout_list
    ignore_tcp_msl = new_resource.ignore_tcp_msl
    icmp_timeout = new_resource.icmp_timeout
    udp_timeout = new_resource.udp_timeout

    params = { "translation": {"uuid": uuid,
        "tcp-timeout": tcp_timeout,
        "service-timeout-list": service_timeout_list,
        "ignore-tcp-msl": ignore_tcp_msl,
        "icmp-timeout": icmp_timeout,
        "udp-timeout": udp_timeout,} }

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
    url = "/axapi/v3/ip/nat/translation"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting translation') do
            client.delete(url)
        end
    end
end