resource_name :a10_sys_ut_template_l2_mac

property :a10_name, String, name_property: true
property :ethernet, String
property :ve, String
property :src_dst, ['dest','src'],required: true
property :address_type, ['broadcast','multicast']
property :nat_pool, String
property :value, String
property :trunk, String
property :virtual_server, String
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sys-ut/template/%<name>s/l2/mac/"
    get_url = "/axapi/v3/sys-ut/template/%<name>s/l2/mac/%<src-dst>s"
    ethernet = new_resource.ethernet
    ve = new_resource.ve
    src_dst = new_resource.src_dst
    address_type = new_resource.address_type
    nat_pool = new_resource.nat_pool
    value = new_resource.value
    trunk = new_resource.trunk
    virtual_server = new_resource.virtual_server
    uuid = new_resource.uuid

    params = { "mac": {"ethernet": ethernet,
        "ve": ve,
        "src-dst": src_dst,
        "address-type": address_type,
        "nat-pool": nat_pool,
        "value": value,
        "trunk": trunk,
        "virtual-server": virtual_server,
        "uuid": uuid,} }

    params[:"mac"].each do |k, v|
        if not v 
            params[:"mac"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating mac') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/l2/mac/%<src-dst>s"
    ethernet = new_resource.ethernet
    ve = new_resource.ve
    src_dst = new_resource.src_dst
    address_type = new_resource.address_type
    nat_pool = new_resource.nat_pool
    value = new_resource.value
    trunk = new_resource.trunk
    virtual_server = new_resource.virtual_server
    uuid = new_resource.uuid

    params = { "mac": {"ethernet": ethernet,
        "ve": ve,
        "src-dst": src_dst,
        "address-type": address_type,
        "nat-pool": nat_pool,
        "value": value,
        "trunk": trunk,
        "virtual-server": virtual_server,
        "uuid": uuid,} }

    params[:"mac"].each do |k, v|
        if not v
            params[:"mac"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["mac"].each do |k, v|
        if v != params[:"mac"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating mac') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sys-ut/template/%<name>s/l2/mac/%<src-dst>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting mac') do
            client.delete(url)
        end
    end
end