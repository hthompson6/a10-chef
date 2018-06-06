resource_name :a10_logging_email_buffer

property :a10_name, String, name_property: true
property :time, Integer
property :uuid, String
property :number, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/email/"
    get_url = "/axapi/v3/logging/email/buffer"
    time = new_resource.time
    uuid = new_resource.uuid
    number = new_resource.number

    params = { "buffer": {"time": time,
        "uuid": uuid,
        "number": number,} }

    params[:"buffer"].each do |k, v|
        if not v 
            params[:"buffer"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating buffer') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/buffer"
    time = new_resource.time
    uuid = new_resource.uuid
    number = new_resource.number

    params = { "buffer": {"time": time,
        "uuid": uuid,
        "number": number,} }

    params[:"buffer"].each do |k, v|
        if not v
            params[:"buffer"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["buffer"].each do |k, v|
        if v != params[:"buffer"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating buffer') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/buffer"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting buffer') do
            client.delete(url)
        end
    end
end