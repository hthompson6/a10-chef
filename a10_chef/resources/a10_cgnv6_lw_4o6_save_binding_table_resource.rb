resource_name :a10_cgnv6_lw_4o6_save_binding_table

property :a10_name, String, name_property: true


property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lw-4o6/"
    get_url = "/axapi/v3/cgnv6/lw-4o6/save-binding-table"
    

    params = { "save-binding-table": {} }

    params[:"save-binding-table"].each do |k, v|
        if not v 
            params[:"save-binding-table"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating save-binding-table') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/save-binding-table"
    

    params = { "save-binding-table": {} }

    params[:"save-binding-table"].each do |k, v|
        if not v
            params[:"save-binding-table"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["save-binding-table"].each do |k, v|
        if v != params[:"save-binding-table"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating save-binding-table') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lw-4o6/save-binding-table"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting save-binding-table') do
            client.delete(url)
        end
    end
end