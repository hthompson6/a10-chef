resource_name :a10_ntp_server_hostname

property :a10_name, String, name_property: true
property :a10_action, ['enable','disable']
property :host_servername, String,required: true
property :prefer, [true, false]
property :uuid, String
property :key, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ntp/server/hostname/"
    get_url = "/axapi/v3/ntp/server/hostname/%<host-servername>s"
    a10_name = new_resource.a10_name
    host_servername = new_resource.host_servername
    prefer = new_resource.prefer
    uuid = new_resource.uuid
    key = new_resource.key

    params = { "hostname": {"action": a10_action,
        "host-servername": host_servername,
        "prefer": prefer,
        "uuid": uuid,
        "key": key,} }

    params[:"hostname"].each do |k, v|
        if not v 
            params[:"hostname"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating hostname') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/server/hostname/%<host-servername>s"
    a10_name = new_resource.a10_name
    host_servername = new_resource.host_servername
    prefer = new_resource.prefer
    uuid = new_resource.uuid
    key = new_resource.key

    params = { "hostname": {"action": a10_action,
        "host-servername": host_servername,
        "prefer": prefer,
        "uuid": uuid,
        "key": key,} }

    params[:"hostname"].each do |k, v|
        if not v
            params[:"hostname"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["hostname"].each do |k, v|
        if v != params[:"hostname"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating hostname') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/server/hostname/%<host-servername>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting hostname') do
            client.delete(url)
        end
    end
end