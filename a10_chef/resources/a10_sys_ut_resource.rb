resource_name :a10_sys_ut

property :a10_name, String, name_property: true
property :uuid, String
property :event_list, Array
property :common, Hash
property :template_list, Array
property :a10_action, ['enable','disable']
property :test_name, String
property :state_list, Array
property :run_test, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/sys-ut"
    uuid = new_resource.uuid
    event_list = new_resource.event_list
    common = new_resource.common
    template_list = new_resource.template_list
    a10_name = new_resource.a10_name
    test_name = new_resource.test_name
    state_list = new_resource.state_list
    run_test = new_resource.run_test

    params = { "sys-ut": {"uuid": uuid,
        "event-list": event_list,
        "common": common,
        "template-list": template_list,
        "action": a10_action,
        "test-name": test_name,
        "state-list": state_list,
        "run-test": run_test,} }

    params[:"sys-ut"].each do |k, v|
        if not v 
            params[:"sys-ut"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sys-ut') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut"
    uuid = new_resource.uuid
    event_list = new_resource.event_list
    common = new_resource.common
    template_list = new_resource.template_list
    a10_name = new_resource.a10_name
    test_name = new_resource.test_name
    state_list = new_resource.state_list
    run_test = new_resource.run_test

    params = { "sys-ut": {"uuid": uuid,
        "event-list": event_list,
        "common": common,
        "template-list": template_list,
        "action": a10_action,
        "test-name": test_name,
        "state-list": state_list,
        "run-test": run_test,} }

    params[:"sys-ut"].each do |k, v|
        if not v
            params[:"sys-ut"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sys-ut"].each do |k, v|
        if v != params[:"sys-ut"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sys-ut') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sys-ut') do
            client.delete(url)
        end
    end
end