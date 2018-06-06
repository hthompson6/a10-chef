resource_name :a10_gslb_dns

property :a10_name, String, name_property: true
property :a10_action, ['none','drop','reject','ignore']
property :sampling_enable, Array
property :logging, ['none','query','response','both']
property :uuid, String
property :template, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/gslb/"
    get_url = "/axapi/v3/gslb/dns"
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    logging = new_resource.logging
    uuid = new_resource.uuid
    template = new_resource.template

    params = { "dns": {"action": a10_action,
        "sampling-enable": sampling_enable,
        "logging": logging,
        "uuid": uuid,
        "template": template,} }

    params[:"dns"].each do |k, v|
        if not v 
            params[:"dns"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/dns"
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    logging = new_resource.logging
    uuid = new_resource.uuid
    template = new_resource.template

    params = { "dns": {"action": a10_action,
        "sampling-enable": sampling_enable,
        "logging": logging,
        "uuid": uuid,
        "template": template,} }

    params[:"dns"].each do |k, v|
        if not v
            params[:"dns"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns"].each do |k, v|
        if v != params[:"dns"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/gslb/dns"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns') do
            client.delete(url)
        end
    end
end