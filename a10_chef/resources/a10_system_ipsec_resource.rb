resource_name :a10_system_ipsec

property :a10_name, String, name_property: true
property :packet_round_robin, [true, false]
property :crypto_core, Integer
property :uuid, String
property :fpga_decrypt, Hash
property :crypto_mem, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/system/"
    get_url = "/axapi/v3/system/ipsec"
    packet_round_robin = new_resource.packet_round_robin
    crypto_core = new_resource.crypto_core
    uuid = new_resource.uuid
    fpga_decrypt = new_resource.fpga_decrypt
    crypto_mem = new_resource.crypto_mem

    params = { "ipsec": {"packet-round-robin": packet_round_robin,
        "crypto-core": crypto_core,
        "uuid": uuid,
        "fpga-decrypt": fpga_decrypt,
        "crypto-mem": crypto_mem,} }

    params[:"ipsec"].each do |k, v|
        if not v 
            params[:"ipsec"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ipsec') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipsec"
    packet_round_robin = new_resource.packet_round_robin
    crypto_core = new_resource.crypto_core
    uuid = new_resource.uuid
    fpga_decrypt = new_resource.fpga_decrypt
    crypto_mem = new_resource.crypto_mem

    params = { "ipsec": {"packet-round-robin": packet_round_robin,
        "crypto-core": crypto_core,
        "uuid": uuid,
        "fpga-decrypt": fpga_decrypt,
        "crypto-mem": crypto_mem,} }

    params[:"ipsec"].each do |k, v|
        if not v
            params[:"ipsec"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ipsec"].each do |k, v|
        if v != params[:"ipsec"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ipsec') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/system/ipsec"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ipsec') do
            client.delete(url)
        end
    end
end