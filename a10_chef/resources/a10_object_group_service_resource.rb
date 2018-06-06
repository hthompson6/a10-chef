resource_name :a10_object_group_service

property :a10_name, String, name_property: true
property :rules, Array
property :svc_name, String,required: true
property :description, String
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/object-group/service/"
    get_url = "/axapi/v3/object-group/service/%<svc-name>s"
    rules = new_resource.rules
    svc_name = new_resource.svc_name
    description = new_resource.description
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "service": {"rules": rules,
        "svc-name": svc_name,
        "description": description,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"service"].each do |k, v|
        if not v 
            params[:"service"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/service/%<svc-name>s"
    rules = new_resource.rules
    svc_name = new_resource.svc_name
    description = new_resource.description
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "service": {"rules": rules,
        "svc-name": svc_name,
        "description": description,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"service"].each do |k, v|
        if not v
            params[:"service"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service"].each do |k, v|
        if v != params[:"service"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/object-group/service/%<svc-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service') do
            client.delete(url)
        end
    end
end