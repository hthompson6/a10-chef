resource_name :a10_aam_authentication_relay_form_based_instance_request_uri

property :a10_name, String, name_property: true
property :other_variables, String
property :max_packet_collect_size, Integer
property :action_uri, String
property :uri, String,required: true
property :user_tag, String
property :cookie, Hash
property :user_variable, String
property :domain_variable, String
property :password_variable, String
property :match_type, ['equals','contains','starts-with','ends-with'],required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s/request-uri/"
    get_url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s/request-uri/%<match-type>s+%<uri>s"
    other_variables = new_resource.other_variables
    max_packet_collect_size = new_resource.max_packet_collect_size
    action_uri = new_resource.action_uri
    uri = new_resource.uri
    user_tag = new_resource.user_tag
    cookie = new_resource.cookie
    user_variable = new_resource.user_variable
    domain_variable = new_resource.domain_variable
    password_variable = new_resource.password_variable
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "request-uri": {"other-variables": other_variables,
        "max-packet-collect-size": max_packet_collect_size,
        "action-uri": action_uri,
        "uri": uri,
        "user-tag": user_tag,
        "cookie": cookie,
        "user-variable": user_variable,
        "domain-variable": domain_variable,
        "password-variable": password_variable,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"request-uri"].each do |k, v|
        if not v 
            params[:"request-uri"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating request-uri') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s/request-uri/%<match-type>s+%<uri>s"
    other_variables = new_resource.other_variables
    max_packet_collect_size = new_resource.max_packet_collect_size
    action_uri = new_resource.action_uri
    uri = new_resource.uri
    user_tag = new_resource.user_tag
    cookie = new_resource.cookie
    user_variable = new_resource.user_variable
    domain_variable = new_resource.domain_variable
    password_variable = new_resource.password_variable
    match_type = new_resource.match_type
    uuid = new_resource.uuid

    params = { "request-uri": {"other-variables": other_variables,
        "max-packet-collect-size": max_packet_collect_size,
        "action-uri": action_uri,
        "uri": uri,
        "user-tag": user_tag,
        "cookie": cookie,
        "user-variable": user_variable,
        "domain-variable": domain_variable,
        "password-variable": password_variable,
        "match-type": match_type,
        "uuid": uuid,} }

    params[:"request-uri"].each do |k, v|
        if not v
            params[:"request-uri"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["request-uri"].each do |k, v|
        if v != params[:"request-uri"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating request-uri') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/form-based/instance/%<name>s/request-uri/%<match-type>s+%<uri>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting request-uri') do
            client.delete(url)
        end
    end
end