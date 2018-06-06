resource_name :a10_ntp_ntp_global

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ntp/"
    get_url = "/axapi/v3/ntp/ntp-global"
    uuid = new_resource.uuid

    params = { "ntp-global": {"uuid": uuid,} }

    params[:"ntp-global"].each do |k, v|
        if not v 
            params[:"ntp-global"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ntp-global') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/ntp-global"
    uuid = new_resource.uuid

    params = { "ntp-global": {"uuid": uuid,} }

    params[:"ntp-global"].each do |k, v|
        if not v
            params[:"ntp-global"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ntp-global"].each do |k, v|
        if v != params[:"ntp-global"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ntp-global') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/ntp-global"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ntp-global') do
            client.delete(url)
        end
    end
end