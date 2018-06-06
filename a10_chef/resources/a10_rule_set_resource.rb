resource_name :a10_rule_set

property :a10_name, String, name_property: true
property :remark, String
property :app, Hash
property :track_app_rule_list, Hash
property :user_tag, String
property :application, Hash
property :sampling_enable, Array
property :tag, Hash
property :rule_list, Array
property :session_statistic, ['enable','disable']
property :rules_by_zone, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/rule-set/"
    get_url = "/axapi/v3/rule-set/%<name>s"
    remark = new_resource.remark
    a10_name = new_resource.a10_name
    app = new_resource.app
    track_app_rule_list = new_resource.track_app_rule_list
    user_tag = new_resource.user_tag
    application = new_resource.application
    sampling_enable = new_resource.sampling_enable
    tag = new_resource.tag
    rule_list = new_resource.rule_list
    session_statistic = new_resource.session_statistic
    rules_by_zone = new_resource.rules_by_zone
    uuid = new_resource.uuid

    params = { "rule-set": {"remark": remark,
        "name": a10_name,
        "app": app,
        "track-app-rule-list": track_app_rule_list,
        "user-tag": user_tag,
        "application": application,
        "sampling-enable": sampling_enable,
        "tag": tag,
        "rule-list": rule_list,
        "session-statistic": session_statistic,
        "rules-by-zone": rules_by_zone,
        "uuid": uuid,} }

    params[:"rule-set"].each do |k, v|
        if not v 
            params[:"rule-set"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating rule-set') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s"
    remark = new_resource.remark
    a10_name = new_resource.a10_name
    app = new_resource.app
    track_app_rule_list = new_resource.track_app_rule_list
    user_tag = new_resource.user_tag
    application = new_resource.application
    sampling_enable = new_resource.sampling_enable
    tag = new_resource.tag
    rule_list = new_resource.rule_list
    session_statistic = new_resource.session_statistic
    rules_by_zone = new_resource.rules_by_zone
    uuid = new_resource.uuid

    params = { "rule-set": {"remark": remark,
        "name": a10_name,
        "app": app,
        "track-app-rule-list": track_app_rule_list,
        "user-tag": user_tag,
        "application": application,
        "sampling-enable": sampling_enable,
        "tag": tag,
        "rule-list": rule_list,
        "session-statistic": session_statistic,
        "rules-by-zone": rules_by_zone,
        "uuid": uuid,} }

    params[:"rule-set"].each do |k, v|
        if not v
            params[:"rule-set"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["rule-set"].each do |k, v|
        if v != params[:"rule-set"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating rule-set') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/rule-set/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting rule-set') do
            client.delete(url)
        end
    end
end