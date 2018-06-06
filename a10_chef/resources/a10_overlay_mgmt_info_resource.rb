resource_name :a10_overlay_mgmt_info

property :a10_name, String, name_property: true
property :appstring, String,required: true
property :uuid, String
property :plugin_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/overlay-mgmt-info/"
    get_url = "/axapi/v3/overlay-mgmt-info/%<plugin_name>s+%<appstring>s"
    appstring = new_resource.appstring
    uuid = new_resource.uuid
    plugin_name = new_resource.plugin_name

    params = { "overlay-mgmt-info": {"appstring": appstring,
        "uuid": uuid,
        "plugin_name": plugin_name,} }

    params[:"overlay-mgmt-info"].each do |k, v|
        if not v 
            params[:"overlay-mgmt-info"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating overlay-mgmt-info') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-mgmt-info/%<plugin_name>s+%<appstring>s"
    appstring = new_resource.appstring
    uuid = new_resource.uuid
    plugin_name = new_resource.plugin_name

    params = { "overlay-mgmt-info": {"appstring": appstring,
        "uuid": uuid,
        "plugin_name": plugin_name,} }

    params[:"overlay-mgmt-info"].each do |k, v|
        if not v
            params[:"overlay-mgmt-info"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["overlay-mgmt-info"].each do |k, v|
        if v != params[:"overlay-mgmt-info"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating overlay-mgmt-info') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/overlay-mgmt-info/%<plugin_name>s+%<appstring>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting overlay-mgmt-info') do
            client.delete(url)
        end
    end
end