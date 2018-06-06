resource_name :a10_gslb_site_slb_dev_vip_server_vip_server_v4

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :ipv4, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s/vip-server/vip-server-v4/"
    get_url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s/vip-server/vip-server-v4/%<ipv4>s"
    sampling_enable = new_resource.sampling_enable
    ipv4 = new_resource.ipv4
    uuid = new_resource.uuid

    params = { "vip-server-v4": {"sampling-enable": sampling_enable,
        "ipv4": ipv4,
        "uuid": uuid,} }

    params[:"vip-server-v4"].each do |k, v|
        if not v 
            params[:"vip-server-v4"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating vip-server-v4') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s/vip-server/vip-server-v4/%<ipv4>s"
    sampling_enable = new_resource.sampling_enable
    ipv4 = new_resource.ipv4
    uuid = new_resource.uuid

    params = { "vip-server-v4": {"sampling-enable": sampling_enable,
        "ipv4": ipv4,
        "uuid": uuid,} }

    params[:"vip-server-v4"].each do |k, v|
        if not v
            params[:"vip-server-v4"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["vip-server-v4"].each do |k, v|
        if v != params[:"vip-server-v4"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating vip-server-v4') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/slb-dev/%<device-name>s/vip-server/vip-server-v4/%<ipv4>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting vip-server-v4') do
            client.delete(url)
        end
    end
end