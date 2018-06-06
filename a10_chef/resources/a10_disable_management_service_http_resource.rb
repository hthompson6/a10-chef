resource_name :a10_disable_management_service_http

property :a10_name, String, name_property: true
property :management, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/disable-management/service/"
    get_url = "/axapi/v3/disable-management/service/http"
    management = new_resource.management
    uuid = new_resource.uuid

    params = { "http": {"management": management,
        "uuid": uuid,} }

    params[:"http"].each do |k, v|
        if not v 
            params[:"http"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/disable-management/service/http"
    management = new_resource.management
    uuid = new_resource.uuid

    params = { "http": {"management": management,
        "uuid": uuid,} }

    params[:"http"].each do |k, v|
        if not v
            params[:"http"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http"].each do |k, v|
        if v != params[:"http"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/disable-management/service/http"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http') do
            client.delete(url)
        end
    end
end