resource_name :a10_slb_template_persist_ssl_sid

property :a10_name, String, name_property: true
property :dont_honor_conn_rules, [true, false]
property :timeout, Integer
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/persist/ssl-sid/"
    get_url = "/axapi/v3/slb/template/persist/ssl-sid/%<name>s"
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    timeout = new_resource.timeout
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "ssl-sid": {"dont-honor-conn-rules": dont_honor_conn_rules,
        "timeout": timeout,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"ssl-sid"].each do |k, v|
        if not v 
            params[:"ssl-sid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ssl-sid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/ssl-sid/%<name>s"
    dont_honor_conn_rules = new_resource.dont_honor_conn_rules
    timeout = new_resource.timeout
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "ssl-sid": {"dont-honor-conn-rules": dont_honor_conn_rules,
        "timeout": timeout,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"ssl-sid"].each do |k, v|
        if not v
            params[:"ssl-sid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ssl-sid"].each do |k, v|
        if v != params[:"ssl-sid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ssl-sid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/persist/ssl-sid/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ssl-sid') do
            client.delete(url)
        end
    end
end