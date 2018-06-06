resource_name :a10_sys_ut_common

property :a10_name, String, name_property: true
property :delay, Integer
property :proceed_on_error, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/"
    get_url = "/axapi/v3/sys-ut/common"
    delay = new_resource.delay
    proceed_on_error = new_resource.proceed_on_error
    uuid = new_resource.uuid

    params = { "common": {"delay": delay,
        "proceed-on-error": proceed_on_error,
        "uuid": uuid,} }

    params[:"common"].each do |k, v|
        if not v 
            params[:"common"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating common') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/common"
    delay = new_resource.delay
    proceed_on_error = new_resource.proceed_on_error
    uuid = new_resource.uuid

    params = { "common": {"delay": delay,
        "proceed-on-error": proceed_on_error,
        "uuid": uuid,} }

    params[:"common"].each do |k, v|
        if not v
            params[:"common"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["common"].each do |k, v|
        if v != params[:"common"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating common') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/common"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting common') do
            client.delete(url)
        end
    end
end