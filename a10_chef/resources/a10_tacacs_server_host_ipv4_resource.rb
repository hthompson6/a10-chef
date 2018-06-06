resource_name :a10_tacacs_server_host_ipv4

property :a10_name, String, name_property: true
property :ipv4_addr, String,required: true
property :secret, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/tacacs-server/host/ipv4/"
    get_url = "/axapi/v3/tacacs-server/host/ipv4/%<ipv4-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    secret = new_resource.secret
    uuid = new_resource.uuid

    params = { "ipv4": {"ipv4-addr": ipv4_addr,
        "secret": secret,
        "uuid": uuid,} }

    params[:"ipv4"].each do |k, v|
        if not v 
            params[:"ipv4"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipv4') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server/host/ipv4/%<ipv4-addr>s"
    ipv4_addr = new_resource.ipv4_addr
    secret = new_resource.secret
    uuid = new_resource.uuid

    params = { "ipv4": {"ipv4-addr": ipv4_addr,
        "secret": secret,
        "uuid": uuid,} }

    params[:"ipv4"].each do |k, v|
        if not v
            params[:"ipv4"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipv4"].each do |k, v|
        if v != params[:"ipv4"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipv4') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/tacacs-server/host/ipv4/%<ipv4-addr>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipv4') do
            client.delete(url)
        end
    end
end