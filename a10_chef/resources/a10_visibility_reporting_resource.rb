resource_name :a10_visibility_reporting

property :a10_name, String, name_property: true
property :reporting_db, Hash
property :sampling_enable, Array
property :session_logging, ['enable','disable']
property :uuid, String
property :notification_template_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/visibility/"
    get_url = "/axapi/v3/visibility/reporting"
    reporting_db = new_resource.reporting_db
    sampling_enable = new_resource.sampling_enable
    session_logging = new_resource.session_logging
    uuid = new_resource.uuid
    notification_template_list = new_resource.notification_template_list

    params = { "reporting": {"reporting-db": reporting_db,
        "sampling-enable": sampling_enable,
        "session-logging": session_logging,
        "uuid": uuid,
        "notification-template-list": notification_template_list,} }

    params[:"reporting"].each do |k, v|
        if not v 
            params[:"reporting"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating reporting') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting"
    reporting_db = new_resource.reporting_db
    sampling_enable = new_resource.sampling_enable
    session_logging = new_resource.session_logging
    uuid = new_resource.uuid
    notification_template_list = new_resource.notification_template_list

    params = { "reporting": {"reporting-db": reporting_db,
        "sampling-enable": sampling_enable,
        "session-logging": session_logging,
        "uuid": uuid,
        "notification-template-list": notification_template_list,} }

    params[:"reporting"].each do |k, v|
        if not v
            params[:"reporting"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["reporting"].each do |k, v|
        if v != params[:"reporting"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating reporting') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/visibility/reporting"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting reporting') do
            client.delete(url)
        end
    end
end