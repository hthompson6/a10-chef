resource_name :a10_ip_nat_alg_pptp

property :a10_name, String, name_property: true
property :pptp, ['disable','enable']
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/alg/"
    get_url = "/axapi/v3/ip/nat/alg/pptp"
    pptp = new_resource.pptp
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "pptp": {"pptp": pptp,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

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
    url = "/axapi/v3/ip/nat/alg/pptp"
    pptp = new_resource.pptp
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "pptp": {"pptp": pptp,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

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
    url = "/axapi/v3/ip/nat/alg/pptp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting pptp') do
            client.delete(url)
        end
    end
end