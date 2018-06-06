resource_name :a10_slb_ssl_expire_check

property :a10_name, String, name_property: true
property :exception, Hash
property :uuid, String
property :ssl_expire_email_address, String
property :interval_days, Integer
property :expire_address1, String
property :before, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/"
    get_url = "/axapi/v3/slb/ssl-expire-check"
    exception = new_resource.exception
    uuid = new_resource.uuid
    ssl_expire_email_address = new_resource.ssl_expire_email_address
    interval_days = new_resource.interval_days
    expire_address1 = new_resource.expire_address1
    before = new_resource.before

    params = { "ssl-expire-check": {"exception": exception,
        "uuid": uuid,
        "ssl-expire-email-address": ssl_expire_email_address,
        "interval-days": interval_days,
        "expire-address1": expire_address1,
        "before": before,} }

    params[:"ssl-expire-check"].each do |k, v|
        if not v 
            params[:"ssl-expire-check"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssl-expire-check') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/ssl-expire-check"
    exception = new_resource.exception
    uuid = new_resource.uuid
    ssl_expire_email_address = new_resource.ssl_expire_email_address
    interval_days = new_resource.interval_days
    expire_address1 = new_resource.expire_address1
    before = new_resource.before

    params = { "ssl-expire-check": {"exception": exception,
        "uuid": uuid,
        "ssl-expire-email-address": ssl_expire_email_address,
        "interval-days": interval_days,
        "expire-address1": expire_address1,
        "before": before,} }

    params[:"ssl-expire-check"].each do |k, v|
        if not v
            params[:"ssl-expire-check"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssl-expire-check"].each do |k, v|
        if v != params[:"ssl-expire-check"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssl-expire-check') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/ssl-expire-check"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssl-expire-check') do
            client.delete(url)
        end
    end
end