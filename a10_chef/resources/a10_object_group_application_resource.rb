resource_name :a10_object_group_application

property :a10_name, String, name_property: true
property :app_list, Array
property :app_name, String,required: true
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/object-group/application/"
    get_url = "/axapi/v3/object-group/application/%<app-name>s"
    app_list = new_resource.app_list
    app_name = new_resource.app_name
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "application": {"app-list": app_list,
        "app-name": app_name,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"application"].each do |k, v|
        if not v 
            params[:"application"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating application') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/application/%<app-name>s"
    app_list = new_resource.app_list
    app_name = new_resource.app_name
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag

    params = { "application": {"app-list": app_list,
        "app-name": app_name,
        "uuid": uuid,
        "user-tag": user_tag,} }

    params[:"application"].each do |k, v|
        if not v
            params[:"application"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["application"].each do |k, v|
        if v != params[:"application"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating application') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/application/%<app-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting application') do
            client.delete(url)
        end
    end
end