resource_name :a10_aam_aaa_policy_aaa_rule

property :a10_name, String, name_property: true
property :index, Integer,required: true
property :match_encoded_uri, [true, false]
property :uuid, String
property :authorize_policy, String
property :uri, Array
property :user_tag, String
property :user_agent, Array
property :host, Array
property :access_list, Hash
property :sampling_enable, Array
property :domain_name, String
property :authentication_template, String
property :a10_action, ['allow','deny']
property :port, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/aaa-policy/%<name>s/aaa-rule/"
    get_url = "/axapi/v3/aam/aaa-policy/%<name>s/aaa-rule/%<index>s"
    index = new_resource.index
    match_encoded_uri = new_resource.match_encoded_uri
    uuid = new_resource.uuid
    authorize_policy = new_resource.authorize_policy
    uri = new_resource.uri
    user_tag = new_resource.user_tag
    user_agent = new_resource.user_agent
    host = new_resource.host
    access_list = new_resource.access_list
    sampling_enable = new_resource.sampling_enable
    domain_name = new_resource.domain_name
    authentication_template = new_resource.authentication_template
    a10_name = new_resource.a10_name
    port = new_resource.port

    params = { "aaa-rule": {"index": index,
        "match-encoded-uri": match_encoded_uri,
        "uuid": uuid,
        "authorize-policy": authorize_policy,
        "uri": uri,
        "user-tag": user_tag,
        "user-agent": user_agent,
        "host": host,
        "access-list": access_list,
        "sampling-enable": sampling_enable,
        "domain-name": domain_name,
        "authentication-template": authentication_template,
        "action": a10_action,
        "port": port,} }

    params[:"aaa-rule"].each do |k, v|
        if not v 
            params[:"aaa-rule"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating aaa-rule') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/aaa-policy/%<name>s/aaa-rule/%<index>s"
    index = new_resource.index
    match_encoded_uri = new_resource.match_encoded_uri
    uuid = new_resource.uuid
    authorize_policy = new_resource.authorize_policy
    uri = new_resource.uri
    user_tag = new_resource.user_tag
    user_agent = new_resource.user_agent
    host = new_resource.host
    access_list = new_resource.access_list
    sampling_enable = new_resource.sampling_enable
    domain_name = new_resource.domain_name
    authentication_template = new_resource.authentication_template
    a10_name = new_resource.a10_name
    port = new_resource.port

    params = { "aaa-rule": {"index": index,
        "match-encoded-uri": match_encoded_uri,
        "uuid": uuid,
        "authorize-policy": authorize_policy,
        "uri": uri,
        "user-tag": user_tag,
        "user-agent": user_agent,
        "host": host,
        "access-list": access_list,
        "sampling-enable": sampling_enable,
        "domain-name": domain_name,
        "authentication-template": authentication_template,
        "action": a10_action,
        "port": port,} }

    params[:"aaa-rule"].each do |k, v|
        if not v
            params[:"aaa-rule"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["aaa-rule"].each do |k, v|
        if v != params[:"aaa-rule"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating aaa-rule') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/aaa-policy/%<name>s/aaa-rule/%<index>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting aaa-rule') do
            client.delete(url)
        end
    end
end