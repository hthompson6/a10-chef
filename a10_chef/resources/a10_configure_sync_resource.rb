resource_name :a10_configure_sync

property :a10_name, String, name_property: true
property :all_partitions, [true, false]
property :private_key, String
property :partition_name, String
property :pwd, String
property :auto_authentication, [true, false]
property :address, String
property :shared, [true, false]
property :ntype, ['running','all']
property :pwd_enc, String
property :usr, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/configure/"
    get_url = "/axapi/v3/configure/sync"
    all_partitions = new_resource.all_partitions
    private_key = new_resource.private_key
    partition_name = new_resource.partition_name
    pwd = new_resource.pwd
    auto_authentication = new_resource.auto_authentication
    address = new_resource.address
    shared = new_resource.shared
    ntype = new_resource.ntype
    pwd_enc = new_resource.pwd_enc
    usr = new_resource.usr

    params = { "sync": {"all-partitions": all_partitions,
        "private-key": private_key,
        "partition-name": partition_name,
        "pwd": pwd,
        "auto-authentication": auto_authentication,
        "address": address,
        "shared": shared,
        "type": ntype,
        "pwd-enc": pwd_enc,
        "usr": usr,} }

    params[:"sync"].each do |k, v|
        if not v 
            params[:"sync"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sync') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/configure/sync"
    all_partitions = new_resource.all_partitions
    private_key = new_resource.private_key
    partition_name = new_resource.partition_name
    pwd = new_resource.pwd
    auto_authentication = new_resource.auto_authentication
    address = new_resource.address
    shared = new_resource.shared
    ntype = new_resource.ntype
    pwd_enc = new_resource.pwd_enc
    usr = new_resource.usr

    params = { "sync": {"all-partitions": all_partitions,
        "private-key": private_key,
        "partition-name": partition_name,
        "pwd": pwd,
        "auto-authentication": auto_authentication,
        "address": address,
        "shared": shared,
        "type": ntype,
        "pwd-enc": pwd_enc,
        "usr": usr,} }

    params[:"sync"].each do |k, v|
        if not v
            params[:"sync"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sync"].each do |k, v|
        if v != params[:"sync"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sync') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/configure/sync"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sync') do
            client.delete(url)
        end
    end
end