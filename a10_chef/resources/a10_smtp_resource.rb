resource_name :a10_smtp

property :a10_name, String, name_property: true
property :mailfrom, String
property :uuid, String
property :smtp_server, String
property :username_cfg, Hash
property :needauthentication, [true, false]
property :port, Integer
property :smtp_server_v6, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/smtp"
    mailfrom = new_resource.mailfrom
    uuid = new_resource.uuid
    smtp_server = new_resource.smtp_server
    username_cfg = new_resource.username_cfg
    needauthentication = new_resource.needauthentication
    port = new_resource.port
    smtp_server_v6 = new_resource.smtp_server_v6

    params = { "smtp": {"mailfrom": mailfrom,
        "uuid": uuid,
        "smtp-server": smtp_server,
        "username-cfg": username_cfg,
        "needauthentication": needauthentication,
        "port": port,
        "smtp-server-v6": smtp_server_v6,} }

    params[:"smtp"].each do |k, v|
        if not v 
            params[:"smtp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating smtp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/smtp"
    mailfrom = new_resource.mailfrom
    uuid = new_resource.uuid
    smtp_server = new_resource.smtp_server
    username_cfg = new_resource.username_cfg
    needauthentication = new_resource.needauthentication
    port = new_resource.port
    smtp_server_v6 = new_resource.smtp_server_v6

    params = { "smtp": {"mailfrom": mailfrom,
        "uuid": uuid,
        "smtp-server": smtp_server,
        "username-cfg": username_cfg,
        "needauthentication": needauthentication,
        "port": port,
        "smtp-server-v6": smtp_server_v6,} }

    params[:"smtp"].each do |k, v|
        if not v
            params[:"smtp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["smtp"].each do |k, v|
        if v != params[:"smtp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating smtp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/smtp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting smtp') do
            client.delete(url)
        end
    end
end