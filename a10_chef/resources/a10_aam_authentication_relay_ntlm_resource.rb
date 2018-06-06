resource_name :a10_aam_authentication_relay_ntlm

property :a10_name, String, name_property: true
property :domain, String
property :user_tag, String
property :sampling_enable, Array
property :version, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/relay/ntlm/"
    get_url = "/axapi/v3/aam/authentication/relay/ntlm/%<name>s"
    domain = new_resource.domain
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    version = new_resource.version
    uuid = new_resource.uuid

    params = { "ntlm": {"domain": domain,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "version": version,
        "uuid": uuid,} }

    params[:"ntlm"].each do |k, v|
        if not v 
            params[:"ntlm"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ntlm') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/ntlm/%<name>s"
    domain = new_resource.domain
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    version = new_resource.version
    uuid = new_resource.uuid

    params = { "ntlm": {"domain": domain,
        "name": a10_name,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "version": version,
        "uuid": uuid,} }

    params[:"ntlm"].each do |k, v|
        if not v
            params[:"ntlm"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ntlm"].each do |k, v|
        if v != params[:"ntlm"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ntlm') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/relay/ntlm/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ntlm') do
            client.delete(url)
        end
    end
end