resource_name :a10_audit

property :a10_name, String, name_property: true
property :privilege, [true, false]
property :enable, [true, false]
property :uuid, String
property :size, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/audit"
    privilege = new_resource.privilege
    enable = new_resource.enable
    uuid = new_resource.uuid
    size = new_resource.size

    params = { "audit": {"privilege": privilege,
        "enable": enable,
        "uuid": uuid,
        "size": size,} }

    params[:"audit"].each do |k, v|
        if not v 
            params[:"audit"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating audit') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/audit"
    privilege = new_resource.privilege
    enable = new_resource.enable
    uuid = new_resource.uuid
    size = new_resource.size

    params = { "audit": {"privilege": privilege,
        "enable": enable,
        "uuid": uuid,
        "size": size,} }

    params[:"audit"].each do |k, v|
        if not v
            params[:"audit"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["audit"].each do |k, v|
        if v != params[:"audit"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating audit') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/audit"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting audit') do
            client.delete(url)
        end
    end
end