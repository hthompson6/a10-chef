resource_name :a10_ntp_auth_key

property :a10_name, String, name_property: true
property :uuid, String
property :encrypted, String
property :key_type, ['ascii','hex']
property :hex_encrypted, String
property :hex_key, String
property :alg_type, ['M','SHA','SHA1']
property :key, Integer,required: true
property :asc_key, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ntp/auth-key/"
    get_url = "/axapi/v3/ntp/auth-key/%<key>s"
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    key_type = new_resource.key_type
    hex_encrypted = new_resource.hex_encrypted
    hex_key = new_resource.hex_key
    alg_type = new_resource.alg_type
    key = new_resource.key
    asc_key = new_resource.asc_key

    params = { "auth-key": {"uuid": uuid,
        "encrypted": encrypted,
        "key-type": key_type,
        "hex-encrypted": hex_encrypted,
        "hex-key": hex_key,
        "alg-type": alg_type,
        "key": key,
        "asc-key": asc_key,} }

    params[:"auth-key"].each do |k, v|
        if not v 
            params[:"auth-key"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating auth-key') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/auth-key/%<key>s"
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    key_type = new_resource.key_type
    hex_encrypted = new_resource.hex_encrypted
    hex_key = new_resource.hex_key
    alg_type = new_resource.alg_type
    key = new_resource.key
    asc_key = new_resource.asc_key

    params = { "auth-key": {"uuid": uuid,
        "encrypted": encrypted,
        "key-type": key_type,
        "hex-encrypted": hex_encrypted,
        "hex-key": hex_key,
        "alg-type": alg_type,
        "key": key,
        "asc-key": asc_key,} }

    params[:"auth-key"].each do |k, v|
        if not v
            params[:"auth-key"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["auth-key"].each do |k, v|
        if v != params[:"auth-key"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating auth-key') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/ntp/auth-key/%<key>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting auth-key') do
            client.delete(url)
        end
    end
end