resource_name :a10_slb_template_cipher

property :a10_name, String, name_property: true
property :cipher_cfg, Array
property :user_tag, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/slb/template/cipher/"
    get_url = "/axapi/v3/slb/template/cipher/%<name>s"
    cipher_cfg = new_resource.cipher_cfg
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "cipher": {"cipher-cfg": cipher_cfg,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"cipher"].each do |k, v|
        if not v 
            params[:"cipher"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating cipher') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/cipher/%<name>s"
    cipher_cfg = new_resource.cipher_cfg
    a10_name = new_resource.a10_name
    user_tag = new_resource.user_tag
    uuid = new_resource.uuid

    params = { "cipher": {"cipher-cfg": cipher_cfg,
        "name": a10_name,
        "user-tag": user_tag,
        "uuid": uuid,} }

    params[:"cipher"].each do |k, v|
        if not v
            params[:"cipher"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["cipher"].each do |k, v|
        if v != params[:"cipher"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating cipher') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/slb/template/cipher/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting cipher') do
            client.delete(url)
        end
    end
end