resource_name :a10_aam_authentication_portal_logon_fail

property :a10_name, String, name_property: true
property :fail_msg_cfg, Hash
property :background, Hash
property :title_cfg, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/portal/%<name>s/"
    get_url = "/axapi/v3/aam/authentication/portal/%<name>s/logon-fail"
    fail_msg_cfg = new_resource.fail_msg_cfg
    background = new_resource.background
    title_cfg = new_resource.title_cfg
    uuid = new_resource.uuid

    params = { "logon-fail": {"fail-msg-cfg": fail_msg_cfg,
        "background": background,
        "title-cfg": title_cfg,
        "uuid": uuid,} }

    params[:"logon-fail"].each do |k, v|
        if not v 
            params[:"logon-fail"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating logon-fail') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/logon-fail"
    fail_msg_cfg = new_resource.fail_msg_cfg
    background = new_resource.background
    title_cfg = new_resource.title_cfg
    uuid = new_resource.uuid

    params = { "logon-fail": {"fail-msg-cfg": fail_msg_cfg,
        "background": background,
        "title-cfg": title_cfg,
        "uuid": uuid,} }

    params[:"logon-fail"].each do |k, v|
        if not v
            params[:"logon-fail"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["logon-fail"].each do |k, v|
        if v != params[:"logon-fail"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating logon-fail') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/portal/%<name>s/logon-fail"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting logon-fail') do
            client.delete(url)
        end
    end
end