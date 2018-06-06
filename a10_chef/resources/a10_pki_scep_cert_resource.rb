resource_name :a10_pki_scep_cert

property :a10_name, String, name_property: true
property :renew_every_type, ['hour','day','week','month']
property :encrypted, String
property :log_level, Integer
property :uuid, String
property :renew_before_type, ['hour','day','week','month']
property :renew_every, [true, false]
property :key_length, ['1024','2048','4096','8192']
property :a10_method, ['GET','POST']
property :dn, String
property :subject_alternate_name, Hash
property :renew_every_value, Integer
property :max_polltime, Integer
property :password, [true, false]
property :minute, Integer
property :secret_string, String
property :enroll, [true, false]
property :renew_before_value, Integer
property :url, String
property :interval, Integer
property :user_tag, String
property :renew_before, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/pki/scep-cert/"
    get_url = "/axapi/v3/pki/scep-cert/%<name>s"
    renew_every_type = new_resource.renew_every_type
    encrypted = new_resource.encrypted
    log_level = new_resource.log_level
    uuid = new_resource.uuid
    renew_before_type = new_resource.renew_before_type
    renew_every = new_resource.renew_every
    key_length = new_resource.key_length
    a10_name = new_resource.a10_name
    dn = new_resource.dn
    subject_alternate_name = new_resource.subject_alternate_name
    renew_every_value = new_resource.renew_every_value
    max_polltime = new_resource.max_polltime
    password = new_resource.password
    minute = new_resource.minute
    secret_string = new_resource.secret_string
    enroll = new_resource.enroll
    renew_before_value = new_resource.renew_before_value
    a10_name = new_resource.a10_name
    url = new_resource.url
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    renew_before = new_resource.renew_before

    params = { "scep-cert": {"renew-every-type": renew_every_type,
        "encrypted": encrypted,
        "log-level": log_level,
        "uuid": uuid,
        "renew-before-type": renew_before_type,
        "renew-every": renew_every,
        "key-length": key_length,
        "method": a10_method,
        "dn": dn,
        "subject-alternate-name": subject_alternate_name,
        "renew-every-value": renew_every_value,
        "max-polltime": max_polltime,
        "password": password,
        "minute": minute,
        "secret-string": secret_string,
        "enroll": enroll,
        "renew-before-value": renew_before_value,
        "name": a10_name,
        "url": url,
        "interval": interval,
        "user-tag": user_tag,
        "renew-before": renew_before,} }

    params[:"scep-cert"].each do |k, v|
        if not v 
            params[:"scep-cert"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating scep-cert') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/scep-cert/%<name>s"
    renew_every_type = new_resource.renew_every_type
    encrypted = new_resource.encrypted
    log_level = new_resource.log_level
    uuid = new_resource.uuid
    renew_before_type = new_resource.renew_before_type
    renew_every = new_resource.renew_every
    key_length = new_resource.key_length
    a10_name = new_resource.a10_name
    dn = new_resource.dn
    subject_alternate_name = new_resource.subject_alternate_name
    renew_every_value = new_resource.renew_every_value
    max_polltime = new_resource.max_polltime
    password = new_resource.password
    minute = new_resource.minute
    secret_string = new_resource.secret_string
    enroll = new_resource.enroll
    renew_before_value = new_resource.renew_before_value
    a10_name = new_resource.a10_name
    url = new_resource.url
    interval = new_resource.interval
    user_tag = new_resource.user_tag
    renew_before = new_resource.renew_before

    params = { "scep-cert": {"renew-every-type": renew_every_type,
        "encrypted": encrypted,
        "log-level": log_level,
        "uuid": uuid,
        "renew-before-type": renew_before_type,
        "renew-every": renew_every,
        "key-length": key_length,
        "method": a10_method,
        "dn": dn,
        "subject-alternate-name": subject_alternate_name,
        "renew-every-value": renew_every_value,
        "max-polltime": max_polltime,
        "password": password,
        "minute": minute,
        "secret-string": secret_string,
        "enroll": enroll,
        "renew-before-value": renew_before_value,
        "name": a10_name,
        "url": url,
        "interval": interval,
        "user-tag": user_tag,
        "renew-before": renew_before,} }

    params[:"scep-cert"].each do |k, v|
        if not v
            params[:"scep-cert"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["scep-cert"].each do |k, v|
        if v != params[:"scep-cert"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating scep-cert') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/scep-cert/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting scep-cert') do
            client.delete(url)
        end
    end
end