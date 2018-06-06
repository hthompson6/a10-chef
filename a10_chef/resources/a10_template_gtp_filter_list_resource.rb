resource_name :a10_template_gtp_filter_list

property :a10_name, String, name_property: true
property :str_list, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/template/gtp-filter-list/"
    get_url = "/axapi/v3/template/gtp-filter-list/%<name>s"
    str_list = new_resource.str_list
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "gtp-filter-list": {"str-list": str_list,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"gtp-filter-list"].each do |k, v|
        if not v 
            params[:"gtp-filter-list"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating gtp-filter-list') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/gtp-filter-list/%<name>s"
    str_list = new_resource.str_list
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "gtp-filter-list": {"str-list": str_list,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"gtp-filter-list"].each do |k, v|
        if not v
            params[:"gtp-filter-list"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["gtp-filter-list"].each do |k, v|
        if v != params[:"gtp-filter-list"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating gtp-filter-list') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/template/gtp-filter-list/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting gtp-filter-list') do
            client.delete(url)
        end
    end
end