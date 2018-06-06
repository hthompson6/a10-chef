resource_name :a10_cloud_services_meta_data

property :a10_name, String, name_property: true
property :uuid, String
property :prevent_user_ops, [true, false]
property :prevent_webservice, [true, false]
property :prevent_license, [true, false]
property :prevent_admin_ssh_key, [true, false]
property :prevent_autofill, [true, false]
property :prevent_admin_passwd, [true, false]
property :prevent_cloud_service, [true, false]
property :a10_provider, ['aws','openstack']
property :a10_action, ['enable','disable']
property :prevent_blob, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cloud-services/"
    get_url = "/axapi/v3/cloud-services/meta-data"
    uuid = new_resource.uuid
    prevent_user_ops = new_resource.prevent_user_ops
    prevent_webservice = new_resource.prevent_webservice
    prevent_license = new_resource.prevent_license
    prevent_admin_ssh_key = new_resource.prevent_admin_ssh_key
    prevent_autofill = new_resource.prevent_autofill
    prevent_admin_passwd = new_resource.prevent_admin_passwd
    prevent_cloud_service = new_resource.prevent_cloud_service
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    prevent_blob = new_resource.prevent_blob

    params = { "meta-data": {"uuid": uuid,
        "prevent-user-ops": prevent_user_ops,
        "prevent-webservice": prevent_webservice,
        "prevent-license": prevent_license,
        "prevent-admin-ssh-key": prevent_admin_ssh_key,
        "prevent-autofill": prevent_autofill,
        "prevent-admin-passwd": prevent_admin_passwd,
        "prevent-cloud-service": prevent_cloud_service,
        "provider": a10_provider,
        "action": a10_action,
        "prevent-blob": prevent_blob,} }

    params[:"meta-data"].each do |k, v|
        if not v 
            params[:"meta-data"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating meta-data') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cloud-services/meta-data"
    uuid = new_resource.uuid
    prevent_user_ops = new_resource.prevent_user_ops
    prevent_webservice = new_resource.prevent_webservice
    prevent_license = new_resource.prevent_license
    prevent_admin_ssh_key = new_resource.prevent_admin_ssh_key
    prevent_autofill = new_resource.prevent_autofill
    prevent_admin_passwd = new_resource.prevent_admin_passwd
    prevent_cloud_service = new_resource.prevent_cloud_service
    a10_name = new_resource.a10_name
    a10_name = new_resource.a10_name
    prevent_blob = new_resource.prevent_blob

    params = { "meta-data": {"uuid": uuid,
        "prevent-user-ops": prevent_user_ops,
        "prevent-webservice": prevent_webservice,
        "prevent-license": prevent_license,
        "prevent-admin-ssh-key": prevent_admin_ssh_key,
        "prevent-autofill": prevent_autofill,
        "prevent-admin-passwd": prevent_admin_passwd,
        "prevent-cloud-service": prevent_cloud_service,
        "provider": a10_provider,
        "action": a10_action,
        "prevent-blob": prevent_blob,} }

    params[:"meta-data"].each do |k, v|
        if not v
            params[:"meta-data"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["meta-data"].each do |k, v|
        if v != params[:"meta-data"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating meta-data') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cloud-services/meta-data"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting meta-data') do
            client.delete(url)
        end
    end
end