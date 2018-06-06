resource_name :a10_health_monitor_method_rtsp

property :a10_name, String, name_property: true
property :rtsp_port, Integer
property :rtsp, [true, false]
property :rtspurl, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/rtsp"
    rtsp_port = new_resource.rtsp_port
    rtsp = new_resource.rtsp
    rtspurl = new_resource.rtspurl
    uuid = new_resource.uuid

    params = { "rtsp": {"rtsp-port": rtsp_port,
        "rtsp": rtsp,
        "rtspurl": rtspurl,
        "uuid": uuid,} }

    params[:"rtsp"].each do |k, v|
        if not v 
            params[:"rtsp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rtsp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/rtsp"
    rtsp_port = new_resource.rtsp_port
    rtsp = new_resource.rtsp
    rtspurl = new_resource.rtspurl
    uuid = new_resource.uuid

    params = { "rtsp": {"rtsp-port": rtsp_port,
        "rtsp": rtsp,
        "rtspurl": rtspurl,
        "uuid": uuid,} }

    params[:"rtsp"].each do |k, v|
        if not v
            params[:"rtsp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rtsp"].each do |k, v|
        if v != params[:"rtsp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rtsp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/rtsp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rtsp') do
            client.delete(url)
        end
    end
end