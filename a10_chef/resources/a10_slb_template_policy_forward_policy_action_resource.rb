resource_name :a10_slb_template_policy_forward_policy_action

property :a10_name, String, name_property: true
property :log, [true, false]
property :forward_snat, String
property :uuid, String
property :http_status_code, ['301','302']
property :action1, ['forward-to-internet','forward-to-service-group','forward-to-proxy','drop']
property :fake_sg, String
property :user_tag, String
property :real_sg, String
property :drop_message, String
property :sampling_enable, Array
property :fall_back, String
property :fall_back_snat, String
property :drop_redirect_url, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/action/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/action/%<name>s"
    log = new_resource.log
    forward_snat = new_resource.forward_snat
    uuid = new_resource.uuid
    http_status_code = new_resource.http_status_code
    action1 = new_resource.action1
    fake_sg = new_resource.fake_sg
    user_tag = new_resource.user_tag
    real_sg = new_resource.real_sg
    drop_message = new_resource.drop_message
    sampling_enable = new_resource.sampling_enable
    fall_back = new_resource.fall_back
    fall_back_snat = new_resource.fall_back_snat
    drop_redirect_url = new_resource.drop_redirect_url
    a10_name = new_resource.a10_name

    params = { "action": {"log": log,
        "forward-snat": forward_snat,
        "uuid": uuid,
        "http-status-code": http_status_code,
        "action1": action1,
        "fake-sg": fake_sg,
        "user-tag": user_tag,
        "real-sg": real_sg,
        "drop-message": drop_message,
        "sampling-enable": sampling_enable,
        "fall-back": fall_back,
        "fall-back-snat": fall_back_snat,
        "drop-redirect-url": drop_redirect_url,
        "name": a10_name,} }

    params[:"action"].each do |k, v|
        if not v 
            params[:"action"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating action') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/action/%<name>s"
    log = new_resource.log
    forward_snat = new_resource.forward_snat
    uuid = new_resource.uuid
    http_status_code = new_resource.http_status_code
    action1 = new_resource.action1
    fake_sg = new_resource.fake_sg
    user_tag = new_resource.user_tag
    real_sg = new_resource.real_sg
    drop_message = new_resource.drop_message
    sampling_enable = new_resource.sampling_enable
    fall_back = new_resource.fall_back
    fall_back_snat = new_resource.fall_back_snat
    drop_redirect_url = new_resource.drop_redirect_url
    a10_name = new_resource.a10_name

    params = { "action": {"log": log,
        "forward-snat": forward_snat,
        "uuid": uuid,
        "http-status-code": http_status_code,
        "action1": action1,
        "fake-sg": fake_sg,
        "user-tag": user_tag,
        "real-sg": real_sg,
        "drop-message": drop_message,
        "sampling-enable": sampling_enable,
        "fall-back": fall_back,
        "fall-back-snat": fall_back_snat,
        "drop-redirect-url": drop_redirect_url,
        "name": a10_name,} }

    params[:"action"].each do |k, v|
        if not v
            params[:"action"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["action"].each do |k, v|
        if v != params[:"action"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating action') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy/action/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting action') do
            client.delete(url)
        end
    end
end