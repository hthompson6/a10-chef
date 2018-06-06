resource_name :a10_slb_template_smpp

property :a10_name, String, name_property: true
property :server_enquire_link, [true, false]
property :server_selection_per_request, [true, false]
property :client_enquire_link, [true, false]
property :user_tag, String
property :server_enquire_link_val, Integer
property :user, String
property :password, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/smpp/"
    get_url = "/axapi/v3/slb/template/smpp/%<name>s"
    a10_name = new_resource.a10_name
    server_enquire_link = new_resource.server_enquire_link
    server_selection_per_request = new_resource.server_selection_per_request
    client_enquire_link = new_resource.client_enquire_link
    user_tag = new_resource.user_tag
    server_enquire_link_val = new_resource.server_enquire_link_val
    user = new_resource.user
    password = new_resource.password
    uuid = new_resource.uuid

    params = { "smpp": {"name": a10_name,
        "server-enquire-link": server_enquire_link,
        "server-selection-per-request": server_selection_per_request,
        "client-enquire-link": client_enquire_link,
        "user-tag": user_tag,
        "server-enquire-link-val": server_enquire_link_val,
        "user": user,
        "password": password,
        "uuid": uuid,} }

    params[:"smpp"].each do |k, v|
        if not v 
            params[:"smpp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating smpp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/smpp/%<name>s"
    a10_name = new_resource.a10_name
    server_enquire_link = new_resource.server_enquire_link
    server_selection_per_request = new_resource.server_selection_per_request
    client_enquire_link = new_resource.client_enquire_link
    user_tag = new_resource.user_tag
    server_enquire_link_val = new_resource.server_enquire_link_val
    user = new_resource.user
    password = new_resource.password
    uuid = new_resource.uuid

    params = { "smpp": {"name": a10_name,
        "server-enquire-link": server_enquire_link,
        "server-selection-per-request": server_selection_per_request,
        "client-enquire-link": client_enquire_link,
        "user-tag": user_tag,
        "server-enquire-link-val": server_enquire_link_val,
        "user": user,
        "password": password,
        "uuid": uuid,} }

    params[:"smpp"].each do |k, v|
        if not v
            params[:"smpp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["smpp"].each do |k, v|
        if v != params[:"smpp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating smpp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/smpp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting smpp') do
            client.delete(url)
        end
    end
end