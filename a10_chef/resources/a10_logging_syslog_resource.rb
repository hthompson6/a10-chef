resource_name :a10_logging_syslog

property :a10_name, String, name_property: true
property :uuid, String
property :syslog_levelname, ['disable','emergency','alert','critical','error','warning','notification','information','debugging']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/syslog"
    uuid = new_resource.uuid
    syslog_levelname = new_resource.syslog_levelname

    params = { "syslog": {"uuid": uuid,
        "syslog-levelname": syslog_levelname,} }

    params[:"syslog"].each do |k, v|
        if not v 
            params[:"syslog"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating syslog') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/syslog"
    uuid = new_resource.uuid
    syslog_levelname = new_resource.syslog_levelname

    params = { "syslog": {"uuid": uuid,
        "syslog-levelname": syslog_levelname,} }

    params[:"syslog"].each do |k, v|
        if not v
            params[:"syslog"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["syslog"].each do |k, v|
        if v != params[:"syslog"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating syslog') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/syslog"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting syslog') do
            client.delete(url)
        end
    end
end