resource_name :a10_cgnv6_template_logging_disable_log_by_destination

property :a10_name, String, name_property: true
property :udp_list, Array
property :icmp, [true, false]
property :uuid, String
property :tcp_list, Array
property :others, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/logging/%<name>s/"
    get_url = "/axapi/v3/cgnv6/template/logging/%<name>s/disable-log-by-destination"
    udp_list = new_resource.udp_list
    icmp = new_resource.icmp
    uuid = new_resource.uuid
    tcp_list = new_resource.tcp_list
    others = new_resource.others

    params = { "disable-log-by-destination": {"udp-list": udp_list,
        "icmp": icmp,
        "uuid": uuid,
        "tcp-list": tcp_list,
        "others": others,} }

    params[:"disable-log-by-destination"].each do |k, v|
        if not v 
            params[:"disable-log-by-destination"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating disable-log-by-destination') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/logging/%<name>s/disable-log-by-destination"
    udp_list = new_resource.udp_list
    icmp = new_resource.icmp
    uuid = new_resource.uuid
    tcp_list = new_resource.tcp_list
    others = new_resource.others

    params = { "disable-log-by-destination": {"udp-list": udp_list,
        "icmp": icmp,
        "uuid": uuid,
        "tcp-list": tcp_list,
        "others": others,} }

    params[:"disable-log-by-destination"].each do |k, v|
        if not v
            params[:"disable-log-by-destination"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["disable-log-by-destination"].each do |k, v|
        if v != params[:"disable-log-by-destination"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating disable-log-by-destination') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/logging/%<name>s/disable-log-by-destination"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting disable-log-by-destination') do
            client.delete(url)
        end
    end
end