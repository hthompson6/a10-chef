resource_name :a10_ip_extcommunity_list_expanded

property :a10_name, String, name_property: true
property :expanded, String,required: true
property :rules_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/extcommunity-list/expanded/"
    get_url = "/axapi/v3/ip/extcommunity-list/expanded/%<expanded>s"
    expanded = new_resource.expanded
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid

    params = { "expanded": {"expanded": expanded,
        "rules-list": rules_list,
        "uuid": uuid,} }

    params[:"expanded"].each do |k, v|
        if not v 
            params[:"expanded"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating expanded') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/extcommunity-list/expanded/%<expanded>s"
    expanded = new_resource.expanded
    rules_list = new_resource.rules_list
    uuid = new_resource.uuid

    params = { "expanded": {"expanded": expanded,
        "rules-list": rules_list,
        "uuid": uuid,} }

    params[:"expanded"].each do |k, v|
        if not v
            params[:"expanded"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["expanded"].each do |k, v|
        if v != params[:"expanded"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating expanded') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/extcommunity-list/expanded/%<expanded>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting expanded') do
            client.delete(url)
        end
    end
end