resource_name :a10_sys_ut_stop_test

property :a10_name, String, name_property: true


property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/"
    get_url = "/axapi/v3/sys-ut/stop-test"
    

    params = { "stop-test": {} }

    params[:"stop-test"].each do |k, v|
        if not v 
            params[:"stop-test"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating stop-test') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/stop-test"
    

    params = { "stop-test": {} }

    params[:"stop-test"].each do |k, v|
        if not v
            params[:"stop-test"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["stop-test"].each do |k, v|
        if v != params[:"stop-test"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating stop-test') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/stop-test"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting stop-test') do
            client.delete(url)
        end
    end
end