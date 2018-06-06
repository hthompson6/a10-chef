resource_name :a10_system_session_reclaim_limit

property :a10_name, String, name_property: true
property :scan_freq, Integer
property :nscan_limit, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/session-reclaim-limit"
    scan_freq = new_resource.scan_freq
    nscan_limit = new_resource.nscan_limit
    uuid = new_resource.uuid

    params = { "session-reclaim-limit": {"scan-freq": scan_freq,
        "nscan-limit": nscan_limit,
        "uuid": uuid,} }

    params[:"session-reclaim-limit"].each do |k, v|
        if not v 
            params[:"session-reclaim-limit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating session-reclaim-limit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/session-reclaim-limit"
    scan_freq = new_resource.scan_freq
    nscan_limit = new_resource.nscan_limit
    uuid = new_resource.uuid

    params = { "session-reclaim-limit": {"scan-freq": scan_freq,
        "nscan-limit": nscan_limit,
        "uuid": uuid,} }

    params[:"session-reclaim-limit"].each do |k, v|
        if not v
            params[:"session-reclaim-limit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["session-reclaim-limit"].each do |k, v|
        if v != params[:"session-reclaim-limit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating session-reclaim-limit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/session-reclaim-limit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting session-reclaim-limit') do
            client.delete(url)
        end
    end
end