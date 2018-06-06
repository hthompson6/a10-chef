resource_name :a10_web_service_secure_generate

property :a10_name, String, name_property: true
property :country, String
property :state, String
property :domain_name, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/web-service/secure/"
    get_url = "/axapi/v3/web-service/secure/generate"
    country = new_resource.country
    state = new_resource.state
    domain_name = new_resource.domain_name

    params = { "generate": {"country": country,
        "state": state,
        "domain-name": domain_name,} }

    params[:"generate"].each do |k, v|
        if not v 
            params[:"generate"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating generate') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure/generate"
    country = new_resource.country
    state = new_resource.state
    domain_name = new_resource.domain_name

    params = { "generate": {"country": country,
        "state": state,
        "domain-name": domain_name,} }

    params[:"generate"].each do |k, v|
        if not v
            params[:"generate"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["generate"].each do |k, v|
        if v != params[:"generate"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating generate') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/web-service/secure/generate"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting generate') do
            client.delete(url)
        end
    end
end