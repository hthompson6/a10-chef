resource_name :a10_locale

property :a10_name, String, name_property: true
property :test, Hash
property :uuid, String
property :value, ['en_US.UTF-8','zh_CN.UTF-8','zh_CN.GB18030','zh_CN.GBK','zh_CN.GB2312','zh_TW.UTF-8','zh_TW.BIG5','zh_TW.EUCTW','ja_JP.UTF-8','ja_JP.EUC-JP']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/locale"
    test = new_resource.test
    uuid = new_resource.uuid
    value = new_resource.value

    params = { "locale": {"test": test,
        "uuid": uuid,
        "value": value,} }

    params[:"locale"].each do |k, v|
        if not v 
            params[:"locale"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating locale') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/locale"
    test = new_resource.test
    uuid = new_resource.uuid
    value = new_resource.value

    params = { "locale": {"test": test,
        "uuid": uuid,
        "value": value,} }

    params[:"locale"].each do |k, v|
        if not v
            params[:"locale"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["locale"].each do |k, v|
        if v != params[:"locale"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating locale') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/locale"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting locale') do
            client.delete(url)
        end
    end
end