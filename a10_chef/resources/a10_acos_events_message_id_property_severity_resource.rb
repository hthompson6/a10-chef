resource_name :a10_acos_events_message_id_property_severity

property :a10_name, String, name_property: true
property :severity_val, ['emergency','alert','critical','error','warning','notification','information','debugging']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/acos-events/message-id/%<log-msg>s/property/"
    get_url = "/axapi/v3/acos-events/message-id/%<log-msg>s/property/severity"
    severity_val = new_resource.severity_val
    uuid = new_resource.uuid

    params = { "severity": {"severity-val": severity_val,
        "uuid": uuid,} }

    params[:"severity"].each do |k, v|
        if not v 
            params[:"severity"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating severity') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-id/%<log-msg>s/property/severity"
    severity_val = new_resource.severity_val
    uuid = new_resource.uuid

    params = { "severity": {"severity-val": severity_val,
        "uuid": uuid,} }

    params[:"severity"].each do |k, v|
        if not v
            params[:"severity"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["severity"].each do |k, v|
        if v != params[:"severity"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating severity') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/acos-events/message-id/%<log-msg>s/property/severity"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting severity') do
            client.delete(url)
        end
    end
end