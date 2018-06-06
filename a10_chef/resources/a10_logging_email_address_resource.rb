resource_name :a10_logging_email_address

property :a10_name, String, name_property: true
property :uuid, String
property :email_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/email-address"
    uuid = new_resource.uuid
    email_list = new_resource.email_list

    params = { "email-address": {"uuid": uuid,
        "email-list": email_list,} }

    params[:"email-address"].each do |k, v|
        if not v 
            params[:"email-address"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating email-address') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email-address"
    uuid = new_resource.uuid
    email_list = new_resource.email_list

    params = { "email-address": {"uuid": uuid,
        "email-list": email_list,} }

    params[:"email-address"].each do |k, v|
        if not v
            params[:"email-address"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["email-address"].each do |k, v|
        if v != params[:"email-address"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating email-address') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email-address"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting email-address') do
            client.delete(url)
        end
    end
end