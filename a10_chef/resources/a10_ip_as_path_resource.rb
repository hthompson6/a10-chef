resource_name :a10_ip_as_path

property :a10_name, String, name_property: true
property :access_list, String,required: true
property :a10_action, ['deny','permit'],required: true
property :uuid, String
property :value, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/as-path/"
    get_url = "/axapi/v3/ip/as-path/%<access-list>s+%<action>s+%<value>s"
    access_list = new_resource.access_list
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    value = new_resource.value

    params = { "as-path": {"access-list": access_list,
        "action": a10_action,
        "uuid": uuid,
        "value": value,} }

    params[:"as-path"].each do |k, v|
        if not v 
            params[:"as-path"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating as-path') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/as-path/%<access-list>s+%<action>s+%<value>s"
    access_list = new_resource.access_list
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    value = new_resource.value

    params = { "as-path": {"access-list": access_list,
        "action": a10_action,
        "uuid": uuid,
        "value": value,} }

    params[:"as-path"].each do |k, v|
        if not v
            params[:"as-path"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["as-path"].each do |k, v|
        if v != params[:"as-path"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating as-path') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ip/as-path/%<access-list>s+%<action>s+%<value>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting as-path') do
            client.delete(url)
        end
    end
end