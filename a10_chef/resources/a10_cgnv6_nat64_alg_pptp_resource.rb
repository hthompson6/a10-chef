resource_name :a10_cgnv6_nat64_alg_pptp

property :a10_name, String, name_property: true
property :uuid, String
property :pptp_enable, ['enable']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat64/alg/"
    get_url = "/axapi/v3/cgnv6/nat64/alg/pptp"
    uuid = new_resource.uuid
    pptp_enable = new_resource.pptp_enable

    params = { "pptp": {"uuid": uuid,
        "pptp-enable": pptp_enable,} }

    params[:"pptp"].each do |k, v|
        if not v 
            params[:"pptp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating pptp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/alg/pptp"
    uuid = new_resource.uuid
    pptp_enable = new_resource.pptp_enable

    params = { "pptp": {"uuid": uuid,
        "pptp-enable": pptp_enable,} }

    params[:"pptp"].each do |k, v|
        if not v
            params[:"pptp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["pptp"].each do |k, v|
        if v != params[:"pptp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating pptp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/alg/pptp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pptp') do
            client.delete(url)
        end
    end
end