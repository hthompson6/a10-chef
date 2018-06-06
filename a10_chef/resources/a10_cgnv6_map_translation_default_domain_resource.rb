resource_name :a10_cgnv6_map_translation_default_domain

property :a10_name, String, name_property: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/map/translation/"
    get_url = "/axapi/v3/cgnv6/map/translation/default-domain"
    uuid = new_resource.uuid

    params = { "default-domain": {"uuid": uuid,} }

    params[:"default-domain"].each do |k, v|
        if not v 
            params[:"default-domain"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating default-domain') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/default-domain"
    uuid = new_resource.uuid

    params = { "default-domain": {"uuid": uuid,} }

    params[:"default-domain"].each do |k, v|
        if not v
            params[:"default-domain"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["default-domain"].each do |k, v|
        if v != params[:"default-domain"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating default-domain') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/map/translation/default-domain"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting default-domain') do
            client.delete(url)
        end
    end
end