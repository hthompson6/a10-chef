resource_name :a10_ip_dns_secondary

property :a10_name, String, name_property: true
property :ip_v4_addr, String
property :ip_v6_addr, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/dns/"
    get_url = "/axapi/v3/ip/dns/secondary"
    ip_v4_addr = new_resource.ip_v4_addr
    ip_v6_addr = new_resource.ip_v6_addr
    uuid = new_resource.uuid

    params = { "secondary": {"ip-v4-addr": ip_v4_addr,
        "ip-v6-addr": ip_v6_addr,
        "uuid": uuid,} }

    params[:"secondary"].each do |k, v|
        if not v 
            params[:"secondary"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating secondary') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/dns/secondary"
    ip_v4_addr = new_resource.ip_v4_addr
    ip_v6_addr = new_resource.ip_v6_addr
    uuid = new_resource.uuid

    params = { "secondary": {"ip-v4-addr": ip_v4_addr,
        "ip-v6-addr": ip_v6_addr,
        "uuid": uuid,} }

    params[:"secondary"].each do |k, v|
        if not v
            params[:"secondary"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["secondary"].each do |k, v|
        if v != params[:"secondary"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating secondary') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/dns/secondary"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting secondary') do
            client.delete(url)
        end
    end
end