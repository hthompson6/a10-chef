resource_name :a10_debug_monitor

property :a10_name, String, name_property: true
property :cpuid, Integer
property :all_slots, [true, false]
property :uuid, String
property :filename, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/monitor"
    cpuid = new_resource.cpuid
    all_slots = new_resource.all_slots
    uuid = new_resource.uuid
    filename = new_resource.filename

    params = { "monitor": {"cpuid": cpuid,
        "all-slots": all_slots,
        "uuid": uuid,
        "filename": filename,} }

    params[:"monitor"].each do |k, v|
        if not v 
            params[:"monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/monitor"
    cpuid = new_resource.cpuid
    all_slots = new_resource.all_slots
    uuid = new_resource.uuid
    filename = new_resource.filename

    params = { "monitor": {"cpuid": cpuid,
        "all-slots": all_slots,
        "uuid": uuid,
        "filename": filename,} }

    params[:"monitor"].each do |k, v|
        if not v
            params[:"monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["monitor"].each do |k, v|
        if v != params[:"monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/monitor"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end