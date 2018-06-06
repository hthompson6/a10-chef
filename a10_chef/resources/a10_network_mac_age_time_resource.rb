resource_name :a10_network_mac_age_time

property :a10_name, String, name_property: true
property :aging_time, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/network/"
    get_url = "/axapi/v3/network/mac-age-time"
    aging_time = new_resource.aging_time
    uuid = new_resource.uuid

    params = { "mac-age-time": {"aging-time": aging_time,
        "uuid": uuid,} }

    params[:"mac-age-time"].each do |k, v|
        if not v 
            params[:"mac-age-time"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mac-age-time') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/mac-age-time"
    aging_time = new_resource.aging_time
    uuid = new_resource.uuid

    params = { "mac-age-time": {"aging-time": aging_time,
        "uuid": uuid,} }

    params[:"mac-age-time"].each do |k, v|
        if not v
            params[:"mac-age-time"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mac-age-time"].each do |k, v|
        if v != params[:"mac-age-time"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mac-age-time') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/network/mac-age-time"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mac-age-time') do
            client.delete(url)
        end
    end
end