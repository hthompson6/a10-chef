resource_name :a10_cgnv6_nat64_alg_tftp

property :a10_name, String, name_property: true
property :tftp_enable, ['enable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat64/alg/"
    get_url = "/axapi/v3/cgnv6/nat64/alg/tftp"
    tftp_enable = new_resource.tftp_enable
    uuid = new_resource.uuid

    params = { "tftp": {"tftp-enable": tftp_enable,
        "uuid": uuid,} }

    params[:"tftp"].each do |k, v|
        if not v 
            params[:"tftp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tftp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/alg/tftp"
    tftp_enable = new_resource.tftp_enable
    uuid = new_resource.uuid

    params = { "tftp": {"tftp-enable": tftp_enable,
        "uuid": uuid,} }

    params[:"tftp"].each do |k, v|
        if not v
            params[:"tftp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tftp"].each do |k, v|
        if v != params[:"tftp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tftp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat64/alg/tftp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tftp') do
            client.delete(url)
        end
    end
end