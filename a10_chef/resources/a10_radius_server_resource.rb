resource_name :a10_radius_server

property :a10_name, String, name_property: true
property :default_privilege_read_write, [true, false]
property :host, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/radius-server"
    default_privilege_read_write = new_resource.default_privilege_read_write
    host = new_resource.host
    uuid = new_resource.uuid

    params = { "radius-server": {"default-privilege-read-write": default_privilege_read_write,
        "host": host,
        "uuid": uuid,} }

    params[:"radius-server"].each do |k, v|
        if not v 
            params[:"radius-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating radius-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server"
    default_privilege_read_write = new_resource.default_privilege_read_write
    host = new_resource.host
    uuid = new_resource.uuid

    params = { "radius-server": {"default-privilege-read-write": default_privilege_read_write,
        "host": host,
        "uuid": uuid,} }

    params[:"radius-server"].each do |k, v|
        if not v
            params[:"radius-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["radius-server"].each do |k, v|
        if v != params[:"radius-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating radius-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting radius-server') do
            client.delete(url)
        end
    end
end