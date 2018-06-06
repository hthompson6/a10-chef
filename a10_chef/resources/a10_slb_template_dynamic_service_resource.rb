resource_name :a10_slb_template_dynamic_service

property :a10_name, String, name_property: true
property :dns_server, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/dynamic-service/"
    get_url = "/axapi/v3/slb/template/dynamic-service/%<name>s"
    dns_server = new_resource.dns_server
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "dynamic-service": {"dns-server": dns_server,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"dynamic-service"].each do |k, v|
        if not v 
            params[:"dynamic-service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dynamic-service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dynamic-service/%<name>s"
    dns_server = new_resource.dns_server
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "dynamic-service": {"dns-server": dns_server,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"dynamic-service"].each do |k, v|
        if not v
            params[:"dynamic-service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dynamic-service"].each do |k, v|
        if v != params[:"dynamic-service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dynamic-service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/dynamic-service/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dynamic-service') do
            client.delete(url)
        end
    end
end