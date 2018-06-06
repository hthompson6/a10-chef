resource_name :a10_locale_test

property :a10_name, String, name_property: true
property :locale, ['zh_CN','zh_TW','ja_JP']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/locale/"
    get_url = "/axapi/v3/locale/test"
    locale = new_resource.locale

    params = { "test": {"locale": locale,} }

    params[:"test"].each do |k, v|
        if not v 
            params[:"test"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating test') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/locale/test"
    locale = new_resource.locale

    params = { "test": {"locale": locale,} }

    params[:"test"].each do |k, v|
        if not v
            params[:"test"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["test"].each do |k, v|
        if v != params[:"test"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating test') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/locale/test"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting test') do
            client.delete(url)
        end
    end
end