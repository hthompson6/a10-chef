resource_name :a10_slb_template_ftp

property :a10_name, String, name_property: true
property :uuid, String
property :user_tag, String
property :to, Integer
property :active_mode_port, [true, false]
property :active_mode_port_val, Integer
property :any, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/ftp/"
    get_url = "/axapi/v3/slb/template/ftp/%<name>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    to = new_resource.to
    active_mode_port = new_resource.active_mode_port
    active_mode_port_val = new_resource.active_mode_port_val
    any = new_resource.any
    a10_name = new_resource.a10_name

    params = { "ftp": {"uuid": uuid,
        "user-tag": user_tag,
        "to": to,
        "active-mode-port": active_mode_port,
        "active-mode-port-val": active_mode_port_val,
        "any": any,
        "name": a10_name,} }

    params[:"ftp"].each do |k, v|
        if not v 
            params[:"ftp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ftp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/ftp/%<name>s"
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    to = new_resource.to
    active_mode_port = new_resource.active_mode_port
    active_mode_port_val = new_resource.active_mode_port_val
    any = new_resource.any
    a10_name = new_resource.a10_name

    params = { "ftp": {"uuid": uuid,
        "user-tag": user_tag,
        "to": to,
        "active-mode-port": active_mode_port,
        "active-mode-port-val": active_mode_port_val,
        "any": any,
        "name": a10_name,} }

    params[:"ftp"].each do |k, v|
        if not v
            params[:"ftp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ftp"].each do |k, v|
        if v != params[:"ftp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ftp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/ftp/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ftp') do
            client.delete(url)
        end
    end
end