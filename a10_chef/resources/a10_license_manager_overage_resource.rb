resource_name :a10_license_manager_overage

property :a10_name, String, name_property: true
property :kb, Integer
property :uuid, String
property :mb, Integer
property :seconds, Integer
property :bytes, Integer
property :days, Integer
property :hours, Integer
property :gb, Integer
property :minutes, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/license-manager/"
    get_url = "/axapi/v3/license-manager/overage"
    kb = new_resource.kb
    uuid = new_resource.uuid
    mb = new_resource.mb
    seconds = new_resource.seconds
    bytes = new_resource.bytes
    days = new_resource.days
    hours = new_resource.hours
    gb = new_resource.gb
    minutes = new_resource.minutes

    params = { "overage": {"kb": kb,
        "uuid": uuid,
        "mb": mb,
        "seconds": seconds,
        "bytes": bytes,
        "days": days,
        "hours": hours,
        "gb": gb,
        "minutes": minutes,} }

    params[:"overage"].each do |k, v|
        if not v 
            params[:"overage"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating overage') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/overage"
    kb = new_resource.kb
    uuid = new_resource.uuid
    mb = new_resource.mb
    seconds = new_resource.seconds
    bytes = new_resource.bytes
    days = new_resource.days
    hours = new_resource.hours
    gb = new_resource.gb
    minutes = new_resource.minutes

    params = { "overage": {"kb": kb,
        "uuid": uuid,
        "mb": mb,
        "seconds": seconds,
        "bytes": bytes,
        "days": days,
        "hours": hours,
        "gb": gb,
        "minutes": minutes,} }

    params[:"overage"].each do |k, v|
        if not v
            params[:"overage"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["overage"].each do |k, v|
        if v != params[:"overage"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating overage') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/license-manager/overage"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting overage') do
            client.delete(url)
        end
    end
end