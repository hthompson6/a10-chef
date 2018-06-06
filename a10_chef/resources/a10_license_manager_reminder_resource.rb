resource_name :a10_license_manager_reminder

property :a10_name, String, name_property: true
property :reminder_value, Integer,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/license-manager/reminder/"
    get_url = "/axapi/v3/license-manager/reminder/%<reminder-value>s"
    reminder_value = new_resource.reminder_value
    uuid = new_resource.uuid

    params = { "reminder": {"reminder-value": reminder_value,
        "uuid": uuid,} }

    params[:"reminder"].each do |k, v|
        if not v 
            params[:"reminder"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reminder') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/reminder/%<reminder-value>s"
    reminder_value = new_resource.reminder_value
    uuid = new_resource.uuid

    params = { "reminder": {"reminder-value": reminder_value,
        "uuid": uuid,} }

    params[:"reminder"].each do |k, v|
        if not v
            params[:"reminder"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reminder"].each do |k, v|
        if v != params[:"reminder"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reminder') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/reminder/%<reminder-value>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reminder') do
            client.delete(url)
        end
    end
end