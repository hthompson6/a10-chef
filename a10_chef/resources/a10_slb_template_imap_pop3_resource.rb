resource_name :a10_slb_template_imap_pop3

property :a10_name, String, name_property: true
property :logindisabled, [true, false]
property :starttls, ['disabled','optional','enforced']
property :uuid, String
property :user_tag, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/imap-pop3/"
    get_url = "/axapi/v3/slb/template/imap-pop3/%<name>s"
    logindisabled = new_resource.logindisabled
    starttls = new_resource.starttls
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "imap-pop3": {"logindisabled": logindisabled,
        "starttls": starttls,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"imap-pop3"].each do |k, v|
        if not v 
            params[:"imap-pop3"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating imap-pop3') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/imap-pop3/%<name>s"
    logindisabled = new_resource.logindisabled
    starttls = new_resource.starttls
    uuid = new_resource.uuid
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name

    params = { "imap-pop3": {"logindisabled": logindisabled,
        "starttls": starttls,
        "uuid": uuid,
        "user-tag": user_tag,
        "name": a10_name,} }

    params[:"imap-pop3"].each do |k, v|
        if not v
            params[:"imap-pop3"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["imap-pop3"].each do |k, v|
        if v != params[:"imap-pop3"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating imap-pop3') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/imap-pop3/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting imap-pop3') do
            client.delete(url)
        end
    end
end