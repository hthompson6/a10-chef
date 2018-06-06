resource_name :a10_netflow_monitor_resend_template

property :a10_name, String, name_property: true
property :records, Integer
property :uuid, String
property :timeout, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/%<name>s/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s/resend-template"
    records = new_resource.records
    uuid = new_resource.uuid
    timeout = new_resource.timeout

    params = { "resend-template": {"records": records,
        "uuid": uuid,
        "timeout": timeout,} }

    params[:"resend-template"].each do |k, v|
        if not v 
            params[:"resend-template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating resend-template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/resend-template"
    records = new_resource.records
    uuid = new_resource.uuid
    timeout = new_resource.timeout

    params = { "resend-template": {"records": records,
        "uuid": uuid,
        "timeout": timeout,} }

    params[:"resend-template"].each do |k, v|
        if not v
            params[:"resend-template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["resend-template"].each do |k, v|
        if v != params[:"resend-template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating resend-template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/resend-template"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting resend-template') do
            client.delete(url)
        end
    end
end