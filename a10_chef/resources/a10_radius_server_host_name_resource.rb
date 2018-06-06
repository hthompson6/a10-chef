resource_name :a10_radius_server_host_name

property :a10_name, String, name_property: true
property :secret, Hash
property :hostname, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/radius-server/host/name/"
    get_url = "/axapi/v3/radius-server/host/name/%<hostname>s"
    secret = new_resource.secret
    hostname = new_resource.hostname
    uuid = new_resource.uuid

    params = { "name": {"secret": secret,
        "hostname": hostname,
        "uuid": uuid,} }

    params[:"name"].each do |k, v|
        if not v 
            params[:"name"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating name') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server/host/name/%<hostname>s"
    secret = new_resource.secret
    hostname = new_resource.hostname
    uuid = new_resource.uuid

    params = { "name": {"secret": secret,
        "hostname": hostname,
        "uuid": uuid,} }

    params[:"name"].each do |k, v|
        if not v
            params[:"name"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["name"].each do |k, v|
        if v != params[:"name"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating name') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/radius-server/host/name/%<hostname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting name') do
            client.delete(url)
        end
    end
end