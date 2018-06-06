resource_name :a10_network_arp_timeout

property :a10_name, String, name_property: true
property :uuid, String
property :timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/arp-timeout"
    uuid = new_resource.uuid
    timeout = new_resource.timeout

    params = { "arp-timeout": {"uuid": uuid,
        "timeout": timeout,} }

    params[:"arp-timeout"].each do |k, v|
        if not v 
            params[:"arp-timeout"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating arp-timeout') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/arp-timeout"
    uuid = new_resource.uuid
    timeout = new_resource.timeout

    params = { "arp-timeout": {"uuid": uuid,
        "timeout": timeout,} }

    params[:"arp-timeout"].each do |k, v|
        if not v
            params[:"arp-timeout"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["arp-timeout"].each do |k, v|
        if v != params[:"arp-timeout"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating arp-timeout') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/arp-timeout"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting arp-timeout') do
            client.delete(url)
        end
    end
end