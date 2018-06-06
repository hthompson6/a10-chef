resource_name :a10_health_monitor_method_smtp

property :a10_name, String, name_property: true
property :smtp_port, Integer
property :smtp_starttls, [true, false]
property :uuid, String
property :smtp_domain, String
property :smtp, [true, false]
property :mail_from, String
property :rcpt_to, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/smtp"
    smtp_port = new_resource.smtp_port
    smtp_starttls = new_resource.smtp_starttls
    uuid = new_resource.uuid
    smtp_domain = new_resource.smtp_domain
    smtp = new_resource.smtp
    mail_from = new_resource.mail_from
    rcpt_to = new_resource.rcpt_to

    params = { "smtp": {"smtp-port": smtp_port,
        "smtp-starttls": smtp_starttls,
        "uuid": uuid,
        "smtp-domain": smtp_domain,
        "smtp": smtp,
        "mail-from": mail_from,
        "rcpt-to": rcpt_to,} }

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
    url = "/axapi/v3/health/monitor/%<name>s/method/smtp"
    smtp_port = new_resource.smtp_port
    smtp_starttls = new_resource.smtp_starttls
    uuid = new_resource.uuid
    smtp_domain = new_resource.smtp_domain
    smtp = new_resource.smtp
    mail_from = new_resource.mail_from
    rcpt_to = new_resource.rcpt_to

    params = { "smtp": {"smtp-port": smtp_port,
        "smtp-starttls": smtp_starttls,
        "uuid": uuid,
        "smtp-domain": smtp_domain,
        "smtp": smtp,
        "mail-from": mail_from,
        "rcpt-to": rcpt_to,} }

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
    url = "/axapi/v3/health/monitor/%<name>s/method/smtp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting smtp') do
            client.delete(url)
        end
    end
end