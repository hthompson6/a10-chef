resource_name :a10_slb_template_policy_forward_policy

property :a10_name, String, name_property: true
property :filtering, Array
property :uuid, String
property :local_logging, [true, false]
property :action_list, Array
property :no_client_conn_reuse, [true, false]
property :source_list, Array

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/policy/%<name>s/"
    get_url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy"
    filtering = new_resource.filtering
    uuid = new_resource.uuid
    local_logging = new_resource.local_logging
    action_list = new_resource.action_list
    no_client_conn_reuse = new_resource.no_client_conn_reuse
    source_list = new_resource.source_list

    params = { "forward-policy": {"filtering": filtering,
        "uuid": uuid,
        "local-logging": local_logging,
        "action-list": action_list,
        "no-client-conn-reuse": no_client_conn_reuse,
        "source-list": source_list,} }

    params[:"forward-policy"].each do |k, v|
        if not v 
            params[:"forward-policy"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating forward-policy') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy"
    filtering = new_resource.filtering
    uuid = new_resource.uuid
    local_logging = new_resource.local_logging
    action_list = new_resource.action_list
    no_client_conn_reuse = new_resource.no_client_conn_reuse
    source_list = new_resource.source_list

    params = { "forward-policy": {"filtering": filtering,
        "uuid": uuid,
        "local-logging": local_logging,
        "action-list": action_list,
        "no-client-conn-reuse": no_client_conn_reuse,
        "source-list": source_list,} }

    params[:"forward-policy"].each do |k, v|
        if not v
            params[:"forward-policy"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["forward-policy"].each do |k, v|
        if v != params[:"forward-policy"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating forward-policy') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/policy/%<name>s/forward-policy"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting forward-policy') do
            client.delete(url)
        end
    end
end