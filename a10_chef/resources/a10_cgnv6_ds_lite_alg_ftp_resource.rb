resource_name :a10_cgnv6_ds_lite_alg_ftp

property :a10_name, String, name_property: true
property :ftp_enable, ['disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/ds-lite/alg/"
    get_url = "/axapi/v3/cgnv6/ds-lite/alg/ftp"
    ftp_enable = new_resource.ftp_enable
    uuid = new_resource.uuid

    params = { "ftp": {"ftp-enable": ftp_enable,
        "uuid": uuid,} }

    params[:"ftp"].each do |k, v|
        if not v 
            params[:"ftp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ftp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ds-lite/alg/ftp"
    ftp_enable = new_resource.ftp_enable
    uuid = new_resource.uuid

    params = { "ftp": {"ftp-enable": ftp_enable,
        "uuid": uuid,} }

    params[:"ftp"].each do |k, v|
        if not v
            params[:"ftp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ftp"].each do |k, v|
        if v != params[:"ftp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ftp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ds-lite/alg/ftp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ftp') do
            client.delete(url)
        end
    end
end