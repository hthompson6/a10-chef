resource_name :a10_cgnv6_nat64_alg_ftp

property :a10_name, String, name_property: true
property :trans_epsv_to_pasv, ['disable']
property :trans_lprt_to_port, ['disable']
property :trans_eprt_to_port, ['disable']
property :xlat_no_trans_pasv, ['enable']
property :ftp_enable, ['disable']
property :trans_lpsv_to_pasv, ['disable']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat64/alg/"
    get_url = "/axapi/v3/cgnv6/nat64/alg/ftp"
    trans_epsv_to_pasv = new_resource.trans_epsv_to_pasv
    trans_lprt_to_port = new_resource.trans_lprt_to_port
    trans_eprt_to_port = new_resource.trans_eprt_to_port
    xlat_no_trans_pasv = new_resource.xlat_no_trans_pasv
    ftp_enable = new_resource.ftp_enable
    trans_lpsv_to_pasv = new_resource.trans_lpsv_to_pasv
    uuid = new_resource.uuid

    params = { "ftp": {"trans-epsv-to-pasv": trans_epsv_to_pasv,
        "trans-lprt-to-port": trans_lprt_to_port,
        "trans-eprt-to-port": trans_eprt_to_port,
        "xlat-no-trans-pasv": xlat_no_trans_pasv,
        "ftp-enable": ftp_enable,
        "trans-lpsv-to-pasv": trans_lpsv_to_pasv,
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
    url = "/axapi/v3/cgnv6/nat64/alg/ftp"
    trans_epsv_to_pasv = new_resource.trans_epsv_to_pasv
    trans_lprt_to_port = new_resource.trans_lprt_to_port
    trans_eprt_to_port = new_resource.trans_eprt_to_port
    xlat_no_trans_pasv = new_resource.xlat_no_trans_pasv
    ftp_enable = new_resource.ftp_enable
    trans_lpsv_to_pasv = new_resource.trans_lpsv_to_pasv
    uuid = new_resource.uuid

    params = { "ftp": {"trans-epsv-to-pasv": trans_epsv_to_pasv,
        "trans-lprt-to-port": trans_lprt_to_port,
        "trans-eprt-to-port": trans_eprt_to_port,
        "xlat-no-trans-pasv": xlat_no_trans_pasv,
        "ftp-enable": ftp_enable,
        "trans-lpsv-to-pasv": trans_lpsv_to_pasv,
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
    url = "/axapi/v3/cgnv6/nat64/alg/ftp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ftp') do
            client.delete(url)
        end
    end
end