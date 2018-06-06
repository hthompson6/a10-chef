resource_name :a10_tacacs_server

property :a10_name, String, name_property: true
property :host, Hash
property :interval, Integer
property :monitor, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/tacacs-server"
    host = new_resource.host
    interval = new_resource.interval
    monitor = new_resource.monitor
    uuid = new_resource.uuid

    params = { "tacacs-server": {"host": host,
        "interval": interval,
        "monitor": monitor,
        "uuid": uuid,} }

    params[:"tacacs-server"].each do |k, v|
        if not v 
            params[:"tacacs-server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tacacs-server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server"
    host = new_resource.host
    interval = new_resource.interval
    monitor = new_resource.monitor
    uuid = new_resource.uuid

    params = { "tacacs-server": {"host": host,
        "interval": interval,
        "monitor": monitor,
        "uuid": uuid,} }

    params[:"tacacs-server"].each do |k, v|
        if not v
            params[:"tacacs-server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tacacs-server"].each do |k, v|
        if v != params[:"tacacs-server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tacacs-server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tacacs-server') do
            client.delete(url)
        end
    end
end