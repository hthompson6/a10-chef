resource_name :a10_cgnv6_template_dns_class_list

property :a10_name, String, name_property: true
property :lid_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/dns/%<name>s/"
    get_url = "/axapi/v3/cgnv6/template/dns/%<name>s/class-list"
    lid_list = new_resource.lid_list
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "class-list": {"lid-list": lid_list,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"class-list"].each do |k, v|
        if not v 
            params[:"class-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating class-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s/class-list"
    lid_list = new_resource.lid_list
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "class-list": {"lid-list": lid_list,
        "name": a10_name,
        "uuid": uuid,} }

    params[:"class-list"].each do |k, v|
        if not v
            params[:"class-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["class-list"].each do |k, v|
        if v != params[:"class-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating class-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s/class-list"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting class-list') do
            client.delete(url)
        end
    end
end