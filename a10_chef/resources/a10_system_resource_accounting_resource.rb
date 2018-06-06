resource_name :a10_system_resource_accounting

property :a10_name, String, name_property: true
property :template_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/resource-accounting"
    template_list = new_resource.template_list

    params = { "resource-accounting": {"template-list": template_list,} }

    params[:"resource-accounting"].each do |k, v|
        if not v 
            params[:"resource-accounting"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating resource-accounting') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting"
    template_list = new_resource.template_list

    params = { "resource-accounting": {"template-list": template_list,} }

    params[:"resource-accounting"].each do |k, v|
        if not v
            params[:"resource-accounting"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["resource-accounting"].each do |k, v|
        if v != params[:"resource-accounting"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating resource-accounting') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting resource-accounting') do
            client.delete(url)
        end
    end
end