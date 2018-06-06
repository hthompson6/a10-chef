resource_name :a10_gslb_policy_auto_map

property :a10_name, String, name_property: true
property :all, [true, false]
property :ttl, Integer
property :uuid, String
property :module_type, ['slb-virtual-server','slb-device','slb-server','gslb-service-ip','gslb-site','gslb-group','hostname']
property :module_disable, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/policy/%<name>s/"
    get_url = "/axapi/v3/gslb/policy/%<name>s/auto-map"
    all = new_resource.all
    ttl = new_resource.ttl
    uuid = new_resource.uuid
    module_type = new_resource.module_type
    module_disable = new_resource.module_disable

    params = { "auto-map": {"all": all,
        "ttl": ttl,
        "uuid": uuid,
        "module-type": module_type,
        "module-disable": module_disable,} }

    params[:"auto-map"].each do |k, v|
        if not v 
            params[:"auto-map"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auto-map') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/auto-map"
    all = new_resource.all
    ttl = new_resource.ttl
    uuid = new_resource.uuid
    module_type = new_resource.module_type
    module_disable = new_resource.module_disable

    params = { "auto-map": {"all": all,
        "ttl": ttl,
        "uuid": uuid,
        "module-type": module_type,
        "module-disable": module_disable,} }

    params[:"auto-map"].each do |k, v|
        if not v
            params[:"auto-map"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auto-map"].each do |k, v|
        if v != params[:"auto-map"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auto-map') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/policy/%<name>s/auto-map"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auto-map') do
            client.delete(url)
        end
    end
end