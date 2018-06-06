resource_name :a10_cgnv6_lsn_alg_rtp

property :a10_name, String, name_property: true
property :rtp_stun_timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn/alg/"
    get_url = "/axapi/v3/cgnv6/lsn/alg/rtp"
    rtp_stun_timeout = new_resource.rtp_stun_timeout
    uuid = new_resource.uuid

    params = { "rtp": {"rtp-stun-timeout": rtp_stun_timeout,
        "uuid": uuid,} }

    params[:"rtp"].each do |k, v|
        if not v 
            params[:"rtp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rtp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/alg/rtp"
    rtp_stun_timeout = new_resource.rtp_stun_timeout
    uuid = new_resource.uuid

    params = { "rtp": {"rtp-stun-timeout": rtp_stun_timeout,
        "uuid": uuid,} }

    params[:"rtp"].each do |k, v|
        if not v
            params[:"rtp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rtp"].each do |k, v|
        if v != params[:"rtp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rtp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn/alg/rtp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rtp') do
            client.delete(url)
        end
    end
end