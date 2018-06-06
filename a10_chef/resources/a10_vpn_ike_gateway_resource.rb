resource_name :a10_vpn_ike_gateway

property :a10_name, String, name_property: true
property :ike_version, ['v1','v2']
property :key_passphrase_encrypted, String
property :local_cert, Hash
property :lifetime, Integer
property :local_id, String
property :enc_cfg, Array
property :uuid, String
property :nat_traversal, [true, false]
property :vrid, Hash
property :preshare_key_value, String
property :key_passphrase, String
property :mode, ['main','aggressive']
property :local_address, Hash
property :key, String
property :preshare_key_encrypted, String
property :remote_address, Hash
property :remote_ca_cert, Hash
property :dh_group, ['1','2','5','14','15','16','18','19','20']
property :user_tag, String
property :sampling_enable, Array
property :dpd, Hash
property :remote_id, String
property :auth_method, ['preshare-key','rsa-signature','ecdsa-signature']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vpn/ike-gateway/"
    get_url = "/axapi/v3/vpn/ike-gateway/%<name>s"
    ike_version = new_resource.ike_version
    key_passphrase_encrypted = new_resource.key_passphrase_encrypted
    local_cert = new_resource.local_cert
    lifetime = new_resource.lifetime
    local_id = new_resource.local_id
    enc_cfg = new_resource.enc_cfg
    uuid = new_resource.uuid
    nat_traversal = new_resource.nat_traversal
    vrid = new_resource.vrid
    preshare_key_value = new_resource.preshare_key_value
    key_passphrase = new_resource.key_passphrase
    mode = new_resource.mode
    local_address = new_resource.local_address
    key = new_resource.key
    preshare_key_encrypted = new_resource.preshare_key_encrypted
    remote_address = new_resource.remote_address
    remote_ca_cert = new_resource.remote_ca_cert
    a10_name = new_resource.a10_name
    dh_group = new_resource.dh_group
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    dpd = new_resource.dpd
    remote_id = new_resource.remote_id
    auth_method = new_resource.auth_method

    params = { "ike-gateway": {"ike-version": ike_version,
        "key-passphrase-encrypted": key_passphrase_encrypted,
        "local-cert": local_cert,
        "lifetime": lifetime,
        "local-id": local_id,
        "enc-cfg": enc_cfg,
        "uuid": uuid,
        "nat-traversal": nat_traversal,
        "vrid": vrid,
        "preshare-key-value": preshare_key_value,
        "key-passphrase": key_passphrase,
        "mode": mode,
        "local-address": local_address,
        "key": key,
        "preshare-key-encrypted": preshare_key_encrypted,
        "remote-address": remote_address,
        "remote-ca-cert": remote_ca_cert,
        "name": a10_name,
        "dh-group": dh_group,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "dpd": dpd,
        "remote-id": remote_id,
        "auth-method": auth_method,} }

    params[:"ike-gateway"].each do |k, v|
        if not v 
            params[:"ike-gateway"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ike-gateway') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ike-gateway/%<name>s"
    ike_version = new_resource.ike_version
    key_passphrase_encrypted = new_resource.key_passphrase_encrypted
    local_cert = new_resource.local_cert
    lifetime = new_resource.lifetime
    local_id = new_resource.local_id
    enc_cfg = new_resource.enc_cfg
    uuid = new_resource.uuid
    nat_traversal = new_resource.nat_traversal
    vrid = new_resource.vrid
    preshare_key_value = new_resource.preshare_key_value
    key_passphrase = new_resource.key_passphrase
    mode = new_resource.mode
    local_address = new_resource.local_address
    key = new_resource.key
    preshare_key_encrypted = new_resource.preshare_key_encrypted
    remote_address = new_resource.remote_address
    remote_ca_cert = new_resource.remote_ca_cert
    a10_name = new_resource.a10_name
    dh_group = new_resource.dh_group
    user_tag = new_resource.user_tag
    sampling_enable = new_resource.sampling_enable
    dpd = new_resource.dpd
    remote_id = new_resource.remote_id
    auth_method = new_resource.auth_method

    params = { "ike-gateway": {"ike-version": ike_version,
        "key-passphrase-encrypted": key_passphrase_encrypted,
        "local-cert": local_cert,
        "lifetime": lifetime,
        "local-id": local_id,
        "enc-cfg": enc_cfg,
        "uuid": uuid,
        "nat-traversal": nat_traversal,
        "vrid": vrid,
        "preshare-key-value": preshare_key_value,
        "key-passphrase": key_passphrase,
        "mode": mode,
        "local-address": local_address,
        "key": key,
        "preshare-key-encrypted": preshare_key_encrypted,
        "remote-address": remote_address,
        "remote-ca-cert": remote_ca_cert,
        "name": a10_name,
        "dh-group": dh_group,
        "user-tag": user_tag,
        "sampling-enable": sampling_enable,
        "dpd": dpd,
        "remote-id": remote_id,
        "auth-method": auth_method,} }

    params[:"ike-gateway"].each do |k, v|
        if not v
            params[:"ike-gateway"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ike-gateway"].each do |k, v|
        if v != params[:"ike-gateway"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ike-gateway') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/ike-gateway/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ike-gateway') do
            client.delete(url)
        end
    end
end