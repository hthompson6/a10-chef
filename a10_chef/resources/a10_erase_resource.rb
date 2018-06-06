resource_name :a10_erase

property :a10_name, String, name_property: true
property :preserve_accounts, [true, false]
property :reload, [true, false]
property :all_partitions, [true, false]
property :preserve_management, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/erase"
    preserve_accounts = new_resource.preserve_accounts
    reload = new_resource.reload
    all_partitions = new_resource.all_partitions
    preserve_management = new_resource.preserve_management

    params = { "erase": {"preserve-accounts": preserve_accounts,
        "reload": reload,
        "all-partitions": all_partitions,
        "preserve-management": preserve_management,} }

    params[:"erase"].each do |k, v|
        if not v 
            params[:"erase"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating erase') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/erase"
    preserve_accounts = new_resource.preserve_accounts
    reload = new_resource.reload
    all_partitions = new_resource.all_partitions
    preserve_management = new_resource.preserve_management

    params = { "erase": {"preserve-accounts": preserve_accounts,
        "reload": reload,
        "all-partitions": all_partitions,
        "preserve-management": preserve_management,} }

    params[:"erase"].each do |k, v|
        if not v
            params[:"erase"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["erase"].each do |k, v|
        if v != params[:"erase"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating erase') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/erase"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting erase') do
            client.delete(url)
        end
    end
end