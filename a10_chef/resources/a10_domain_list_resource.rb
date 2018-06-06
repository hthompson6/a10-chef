resource_name :a10_domain_list

property :a10_name, String, name_property: true
property :domain_name_list, Array
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/domain-list/"
    get_url = "/axapi/v3/domain-list/%<name>s"
    domain_name_list = new_resource.domain_name_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "domain-list": {"domain-name-list": domain_name_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"domain-list"].each do |k, v|
        if not v 
            params[:"domain-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating domain-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/domain-list/%<name>s"
    domain_name_list = new_resource.domain_name_list
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "domain-list": {"domain-name-list": domain_name_list,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"domain-list"].each do |k, v|
        if not v
            params[:"domain-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["domain-list"].each do |k, v|
        if v != params[:"domain-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating domain-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/domain-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting domain-list') do
            client.delete(url)
        end
    end
end