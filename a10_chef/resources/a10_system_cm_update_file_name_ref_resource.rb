resource_name :a10_system_cm_update_file_name_ref

property :a10_name, String, name_property: true
property :source_name, String
property :id, Integer
property :dest_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/cm-update-file-name-ref"
    source_name = new_resource.source_name
    id = new_resource.id
    dest_name = new_resource.dest_name

    params = { "cm-update-file-name-ref": {"source_name": source_name,
        "id": id,
        "dest_name": dest_name,} }

    params[:"cm-update-file-name-ref"].each do |k, v|
        if not v 
            params[:"cm-update-file-name-ref"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cm-update-file-name-ref') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cm-update-file-name-ref"
    source_name = new_resource.source_name
    id = new_resource.id
    dest_name = new_resource.dest_name

    params = { "cm-update-file-name-ref": {"source_name": source_name,
        "id": id,
        "dest_name": dest_name,} }

    params[:"cm-update-file-name-ref"].each do |k, v|
        if not v
            params[:"cm-update-file-name-ref"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cm-update-file-name-ref"].each do |k, v|
        if v != params[:"cm-update-file-name-ref"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cm-update-file-name-ref') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/cm-update-file-name-ref"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cm-update-file-name-ref') do
            client.delete(url)
        end
    end
end