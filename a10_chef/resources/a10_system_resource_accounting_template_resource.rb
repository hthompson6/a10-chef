resource_name :a10_system_resource_accounting_template

property :a10_name, String, name_property: true
property :app_resources, Hash
property :system_resources, Hash
property :user_tag, String
property :network_resources, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/resource-accounting/template/"
    get_url = "/axapi/v3/system/resource-accounting/template/%<name>s"
    app_resources = new_resource.app_resources
    a10_name = new_resource.a10_name
    system_resources = new_resource.system_resources
    user_tag = new_resource.user_tag
    network_resources = new_resource.network_resources
    uuid = new_resource.uuid

    params = { "template": {"app-resources": app_resources,
        "name": a10_name,
        "system-resources": system_resources,
        "user-tag": user_tag,
        "network-resources": network_resources,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s"
    app_resources = new_resource.app_resources
    a10_name = new_resource.a10_name
    system_resources = new_resource.system_resources
    user_tag = new_resource.user_tag
    network_resources = new_resource.network_resources
    uuid = new_resource.uuid

    params = { "template": {"app-resources": app_resources,
        "name": a10_name,
        "system-resources": system_resources,
        "user-tag": user_tag,
        "network-resources": network_resources,
        "uuid": uuid,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/resource-accounting/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end