resource_name :a10_tacacs_server_host_tacacs_hostname

property :a10_name, String, name_property: true
property :secret, Hash
property :hostname, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/tacacs-server/host/tacacs-hostname/"
    get_url = "/axapi/v3/tacacs-server/host/tacacs-hostname/%<hostname>s"
    secret = new_resource.secret
    hostname = new_resource.hostname
    uuid = new_resource.uuid

    params = { "tacacs-hostname": {"secret": secret,
        "hostname": hostname,
        "uuid": uuid,} }

    params[:"tacacs-hostname"].each do |k, v|
        if not v 
            params[:"tacacs-hostname"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating tacacs-hostname') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server/host/tacacs-hostname/%<hostname>s"
    secret = new_resource.secret
    hostname = new_resource.hostname
    uuid = new_resource.uuid

    params = { "tacacs-hostname": {"secret": secret,
        "hostname": hostname,
        "uuid": uuid,} }

    params[:"tacacs-hostname"].each do |k, v|
        if not v
            params[:"tacacs-hostname"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["tacacs-hostname"].each do |k, v|
        if v != params[:"tacacs-hostname"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating tacacs-hostname') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server/host/tacacs-hostname/%<hostname>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting tacacs-hostname') do
            client.delete(url)
        end
    end
end