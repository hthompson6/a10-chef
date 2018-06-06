resource_name :a10_application_type

property :a10_name, String, name_property: true
property :ntype, ['adc','cgnv6']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/application-type"
    ntype = new_resource.ntype
    uuid = new_resource.uuid

    params = { "application-type": {"type": ntype,
        "uuid": uuid,} }

    params[:"application-type"].each do |k, v|
        if not v 
            params[:"application-type"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating application-type') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/application-type"
    ntype = new_resource.ntype
    uuid = new_resource.uuid

    params = { "application-type": {"type": ntype,
        "uuid": uuid,} }

    params[:"application-type"].each do |k, v|
        if not v
            params[:"application-type"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["application-type"].each do |k, v|
        if v != params[:"application-type"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating application-type') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/application-type"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting application-type') do
            client.delete(url)
        end
    end
end