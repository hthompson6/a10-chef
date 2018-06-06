resource_name :a10_health_monitor_method_compound

property :a10_name, String, name_property: true
property :rpn_string, String
property :uuid, String
property :compound, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/compound"
    rpn_string = new_resource.rpn_string
    uuid = new_resource.uuid
    compound = new_resource.compound

    params = { "compound": {"rpn-string": rpn_string,
        "uuid": uuid,
        "compound": compound,} }

    params[:"compound"].each do |k, v|
        if not v 
            params[:"compound"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating compound') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/compound"
    rpn_string = new_resource.rpn_string
    uuid = new_resource.uuid
    compound = new_resource.compound

    params = { "compound": {"rpn-string": rpn_string,
        "uuid": uuid,
        "compound": compound,} }

    params[:"compound"].each do |k, v|
        if not v
            params[:"compound"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["compound"].each do |k, v|
        if v != params[:"compound"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating compound') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/compound"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting compound') do
            client.delete(url)
        end
    end
end