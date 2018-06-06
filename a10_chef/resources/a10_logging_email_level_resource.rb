resource_name :a10_logging_email_level

property :a10_name, String, name_property: true
property :email_levelname, ['disable','emergency','alert','critical','notification']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/email/"
    get_url = "/axapi/v3/logging/email/level"
    email_levelname = new_resource.email_levelname
    uuid = new_resource.uuid

    params = { "level": {"email-levelname": email_levelname,
        "uuid": uuid,} }

    params[:"level"].each do |k, v|
        if not v 
            params[:"level"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating level') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/level"
    email_levelname = new_resource.email_levelname
    uuid = new_resource.uuid

    params = { "level": {"email-levelname": email_levelname,
        "uuid": uuid,} }

    params[:"level"].each do |k, v|
        if not v
            params[:"level"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["level"].each do |k, v|
        if v != params[:"level"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating level') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/level"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting level') do
            client.delete(url)
        end
    end
end