resource_name :a10_gslb_protocol

property :a10_name, String, name_property: true
property :uuid, String
property :use_mgmt_port, [true, false]
property :limit, Hash
property :ping_site, String
property :auto_detect, [true, false]
property :enable_list, Array
property :status_interval, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/"
    get_url = "/axapi/v3/gslb/protocol"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    limit = new_resource.limit
    ping_site = new_resource.ping_site
    auto_detect = new_resource.auto_detect
    enable_list = new_resource.enable_list
    status_interval = new_resource.status_interval

    params = { "protocol": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "limit": limit,
        "ping-site": ping_site,
        "auto-detect": auto_detect,
        "enable-list": enable_list,
        "status-interval": status_interval,} }

    params[:"protocol"].each do |k, v|
        if not v 
            params[:"protocol"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating protocol') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/protocol"
    uuid = new_resource.uuid
    use_mgmt_port = new_resource.use_mgmt_port
    limit = new_resource.limit
    ping_site = new_resource.ping_site
    auto_detect = new_resource.auto_detect
    enable_list = new_resource.enable_list
    status_interval = new_resource.status_interval

    params = { "protocol": {"uuid": uuid,
        "use-mgmt-port": use_mgmt_port,
        "limit": limit,
        "ping-site": ping_site,
        "auto-detect": auto_detect,
        "enable-list": enable_list,
        "status-interval": status_interval,} }

    params[:"protocol"].each do |k, v|
        if not v
            params[:"protocol"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["protocol"].each do |k, v|
        if v != params[:"protocol"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating protocol') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/protocol"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting protocol') do
            client.delete(url)
        end
    end
end