resource_name :a10_file_inspection_template

property :a10_name, String, name_property: true
property :bad_uploads_action, ['reset','drop','allow']
property :suspect_uploads_action, ['reset','drop','allow']
property :downloads_bad_log, ['log','no-log']
property :uploads_bad_log, ['log','no-log']
property :uploads_suspect_log, ['log','no-log']
property :good_uploads_action, ['reset','drop','allow']
property :a10_inspect, Hash
property :uuid, String
property :suspect_downloads_action, ['reset','drop','allow']
property :downloads_good_log, ['log','no-log']
property :uploads_external_inspect, String
property :user_tag, String
property :downloads_external_inspect, String
property :downloads_external_suspect_log, ['log','no-log']
property :downloads_suspect_log, ['log','no-log']
property :good_downloads_action, ['reset','drop','allow']
property :bad_downloads_action, ['reset','drop','allow']
property :uploads_good_log, ['log','no-log']
property :uploads_external_suspect_log, ['log','no-log']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/file-inspection/template/"
    get_url = "/axapi/v3/file-inspection/template/%<name>s"
    bad_uploads_action = new_resource.bad_uploads_action
    suspect_uploads_action = new_resource.suspect_uploads_action
    downloads_bad_log = new_resource.downloads_bad_log
    uploads_bad_log = new_resource.uploads_bad_log
    uploads_suspect_log = new_resource.uploads_suspect_log
    good_uploads_action = new_resource.good_uploads_action
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    suspect_downloads_action = new_resource.suspect_downloads_action
    downloads_good_log = new_resource.downloads_good_log
    uploads_external_inspect = new_resource.uploads_external_inspect
    user_tag = new_resource.user_tag
    downloads_external_inspect = new_resource.downloads_external_inspect
    downloads_external_suspect_log = new_resource.downloads_external_suspect_log
    downloads_suspect_log = new_resource.downloads_suspect_log
    good_downloads_action = new_resource.good_downloads_action
    bad_downloads_action = new_resource.bad_downloads_action
    uploads_good_log = new_resource.uploads_good_log
    uploads_external_suspect_log = new_resource.uploads_external_suspect_log
    a10_name = new_resource.a10_name

    params = { "template": {"bad-uploads-action": bad_uploads_action,
        "suspect-uploads-action": suspect_uploads_action,
        "downloads-bad-log": downloads_bad_log,
        "uploads-bad-log": uploads_bad_log,
        "uploads-suspect-log": uploads_suspect_log,
        "good-uploads-action": good_uploads_action,
        "inspect": a10_inspect,
        "uuid": uuid,
        "suspect-downloads-action": suspect_downloads_action,
        "downloads-good-log": downloads_good_log,
        "uploads-external-inspect": uploads_external_inspect,
        "user-tag": user_tag,
        "downloads-external-inspect": downloads_external_inspect,
        "downloads-external-suspect-log": downloads_external_suspect_log,
        "downloads-suspect-log": downloads_suspect_log,
        "good-downloads-action": good_downloads_action,
        "bad-downloads-action": bad_downloads_action,
        "uploads-good-log": uploads_good_log,
        "uploads-external-suspect-log": uploads_external_suspect_log,
        "name": a10_name,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/template/%<name>s"
    bad_uploads_action = new_resource.bad_uploads_action
    suspect_uploads_action = new_resource.suspect_uploads_action
    downloads_bad_log = new_resource.downloads_bad_log
    uploads_bad_log = new_resource.uploads_bad_log
    uploads_suspect_log = new_resource.uploads_suspect_log
    good_uploads_action = new_resource.good_uploads_action
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid
    suspect_downloads_action = new_resource.suspect_downloads_action
    downloads_good_log = new_resource.downloads_good_log
    uploads_external_inspect = new_resource.uploads_external_inspect
    user_tag = new_resource.user_tag
    downloads_external_inspect = new_resource.downloads_external_inspect
    downloads_external_suspect_log = new_resource.downloads_external_suspect_log
    downloads_suspect_log = new_resource.downloads_suspect_log
    good_downloads_action = new_resource.good_downloads_action
    bad_downloads_action = new_resource.bad_downloads_action
    uploads_good_log = new_resource.uploads_good_log
    uploads_external_suspect_log = new_resource.uploads_external_suspect_log
    a10_name = new_resource.a10_name

    params = { "template": {"bad-uploads-action": bad_uploads_action,
        "suspect-uploads-action": suspect_uploads_action,
        "downloads-bad-log": downloads_bad_log,
        "uploads-bad-log": uploads_bad_log,
        "uploads-suspect-log": uploads_suspect_log,
        "good-uploads-action": good_uploads_action,
        "inspect": a10_inspect,
        "uuid": uuid,
        "suspect-downloads-action": suspect_downloads_action,
        "downloads-good-log": downloads_good_log,
        "uploads-external-inspect": uploads_external_inspect,
        "user-tag": user_tag,
        "downloads-external-inspect": downloads_external_inspect,
        "downloads-external-suspect-log": downloads_external_suspect_log,
        "downloads-suspect-log": downloads_suspect_log,
        "good-downloads-action": good_downloads_action,
        "bad-downloads-action": bad_downloads_action,
        "uploads-good-log": uploads_good_log,
        "uploads-external-suspect-log": uploads_external_suspect_log,
        "name": a10_name,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/file-inspection/template/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end