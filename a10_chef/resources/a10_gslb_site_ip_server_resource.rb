resource_name :a10_gslb_site_ip_server

property :a10_name, String, name_property: true
property :ip_server_name, String,required: true
property :sampling_enable, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/site/%<site-name>s/ip-server/"
    get_url = "/axapi/v3/gslb/site/%<site-name>s/ip-server/%<ip-server-name>s"
    ip_server_name = new_resource.ip_server_name
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "ip-server": {"ip-server-name": ip_server_name,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"ip-server"].each do |k, v|
        if not v 
            params[:"ip-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ip-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/ip-server/%<ip-server-name>s"
    ip_server_name = new_resource.ip_server_name
    sampling_enable = new_resource.sampling_enable
    uuid = new_resource.uuid

    params = { "ip-server": {"ip-server-name": ip_server_name,
        "sampling-enable": sampling_enable,
        "uuid": uuid,} }

    params[:"ip-server"].each do |k, v|
        if not v
            params[:"ip-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ip-server"].each do |k, v|
        if v != params[:"ip-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ip-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/site/%<site-name>s/ip-server/%<ip-server-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ip-server') do
            client.delete(url)
        end
    end
end