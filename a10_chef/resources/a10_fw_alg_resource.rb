resource_name :a10_fw_alg

property :a10_name, String, name_property: true
property :ftp, Hash
property :sip, Hash
property :uuid, String
property :pptp, Hash
property :rtsp, Hash
property :dns, Hash
property :tftp, Hash
property :icmp, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/"
    get_url = "/axapi/v3/fw/alg"
    ftp = new_resource.ftp
    sip = new_resource.sip
    uuid = new_resource.uuid
    pptp = new_resource.pptp
    rtsp = new_resource.rtsp
    dns = new_resource.dns
    tftp = new_resource.tftp
    icmp = new_resource.icmp

    params = { "alg": {"ftp": ftp,
        "sip": sip,
        "uuid": uuid,
        "pptp": pptp,
        "rtsp": rtsp,
        "dns": dns,
        "tftp": tftp,
        "icmp": icmp,} }

    params[:"alg"].each do |k, v|
        if not v 
            params[:"alg"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating alg') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/alg"
    ftp = new_resource.ftp
    sip = new_resource.sip
    uuid = new_resource.uuid
    pptp = new_resource.pptp
    rtsp = new_resource.rtsp
    dns = new_resource.dns
    tftp = new_resource.tftp
    icmp = new_resource.icmp

    params = { "alg": {"ftp": ftp,
        "sip": sip,
        "uuid": uuid,
        "pptp": pptp,
        "rtsp": rtsp,
        "dns": dns,
        "tftp": tftp,
        "icmp": icmp,} }

    params[:"alg"].each do |k, v|
        if not v
            params[:"alg"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["alg"].each do |k, v|
        if v != params[:"alg"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating alg') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/alg"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting alg') do
            client.delete(url)
        end
    end
end