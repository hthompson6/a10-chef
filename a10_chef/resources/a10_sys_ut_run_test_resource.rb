resource_name :a10_sys_ut_run_test

property :a10_name, String, name_property: true
property :mode, ['basic','fault-injection','cpu-rr','frag']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/"
    get_url = "/axapi/v3/sys-ut/run-test"
    mode = new_resource.mode

    params = { "run-test": {"mode": mode,} }

    params[:"run-test"].each do |k, v|
        if not v 
            params[:"run-test"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating run-test') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/run-test"
    mode = new_resource.mode

    params = { "run-test": {"mode": mode,} }

    params[:"run-test"].each do |k, v|
        if not v
            params[:"run-test"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["run-test"].each do |k, v|
        if v != params[:"run-test"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating run-test') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/run-test"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting run-test') do
            client.delete(url)
        end
    end
end