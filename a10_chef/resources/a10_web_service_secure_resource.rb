resource_name :a10_web_service_secure

property :a10_name, String, name_property: true
property :certificate, Hash
property :regenerate, Hash
property :wipe, [true, false]
property :private_key, Hash
property :generate, Hash
property :restart, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/web-service/"
    get_url = "/axapi/v3/web-service/secure"
    certificate = new_resource.certificate
    regenerate = new_resource.regenerate
    wipe = new_resource.wipe
    private_key = new_resource.private_key
    generate = new_resource.generate
    restart = new_resource.restart

    params = { "secure": {"certificate": certificate,
        "regenerate": regenerate,
        "wipe": wipe,
        "private-key": private_key,
        "generate": generate,
        "restart": restart,} }

    params[:"secure"].each do |k, v|
        if not v 
            params[:"secure"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating secure') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure"
    certificate = new_resource.certificate
    regenerate = new_resource.regenerate
    wipe = new_resource.wipe
    private_key = new_resource.private_key
    generate = new_resource.generate
    restart = new_resource.restart

    params = { "secure": {"certificate": certificate,
        "regenerate": regenerate,
        "wipe": wipe,
        "private-key": private_key,
        "generate": generate,
        "restart": restart,} }

    params[:"secure"].each do |k, v|
        if not v
            params[:"secure"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["secure"].each do |k, v|
        if v != params[:"secure"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating secure') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting secure') do
            client.delete(url)
        end
    end
end