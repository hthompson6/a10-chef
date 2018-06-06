resource_name :a10_logging_email_filter

property :a10_name, String, name_property: true
property :filter_id, Integer,required: true
property :trigger, [true, false]
property :expression, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/email/filter/"
    get_url = "/axapi/v3/logging/email/filter/%<filter-id>s"
    filter_id = new_resource.filter_id
    trigger = new_resource.trigger
    expression = new_resource.expression
    uuid = new_resource.uuid

    params = { "filter": {"filter-id": filter_id,
        "trigger": trigger,
        "expression": expression,
        "uuid": uuid,} }

    params[:"filter"].each do |k, v|
        if not v 
            params[:"filter"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating filter') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/filter/%<filter-id>s"
    filter_id = new_resource.filter_id
    trigger = new_resource.trigger
    expression = new_resource.expression
    uuid = new_resource.uuid

    params = { "filter": {"filter-id": filter_id,
        "trigger": trigger,
        "expression": expression,
        "uuid": uuid,} }

    params[:"filter"].each do |k, v|
        if not v
            params[:"filter"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["filter"].each do |k, v|
        if v != params[:"filter"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating filter') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/email/filter/%<filter-id>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting filter') do
            client.delete(url)
        end
    end
end