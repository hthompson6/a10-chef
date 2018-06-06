resource_name :a10_sys_ut_template_ignore_validation

property :a10_name, String, name_property: true
property :all, [true, false]
property :uuid, String
property :l4, [true, false]
property :l2, [true, false]
property :l3, [true, false]
property :l1, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/%<name>s/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s/ignore-validation"
    all = new_resource.all
    uuid = new_resource.uuid
    l4 = new_resource.l4
    l2 = new_resource.l2
    l3 = new_resource.l3
    l1 = new_resource.l1

    params = { "ignore-validation": {"all": all,
        "uuid": uuid,
        "l4": l4,
        "l2": l2,
        "l3": l3,
        "l1": l1,} }

    params[:"ignore-validation"].each do |k, v|
        if not v 
            params[:"ignore-validation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ignore-validation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/ignore-validation"
    all = new_resource.all
    uuid = new_resource.uuid
    l4 = new_resource.l4
    l2 = new_resource.l2
    l3 = new_resource.l3
    l1 = new_resource.l1

    params = { "ignore-validation": {"all": all,
        "uuid": uuid,
        "l4": l4,
        "l2": l2,
        "l3": l3,
        "l1": l1,} }

    params[:"ignore-validation"].each do |k, v|
        if not v
            params[:"ignore-validation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ignore-validation"].each do |k, v|
        if v != params[:"ignore-validation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ignore-validation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/ignore-validation"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ignore-validation') do
            client.delete(url)
        end
    end
end