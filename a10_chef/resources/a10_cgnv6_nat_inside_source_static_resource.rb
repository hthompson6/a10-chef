resource_name :a10_cgnv6_nat_inside_source_static

property :a10_name, String, name_property: true
property :nat_address, String
property :partition, String,required: true
property :vrid, Integer
property :src_address, String,required: true
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/nat/inside/source/static/"
    get_url = "/axapi/v3/cgnv6/nat/inside/source/static/%<src-address>s+%<partition>s"
    nat_address = new_resource.nat_address
    partition = new_resource.partition
    vrid = new_resource.vrid
    src_address = new_resource.src_address
    uuid = new_resource.uuid

    params = { "static": {"nat-address": nat_address,
        "partition": partition,
        "vrid": vrid,
        "src-address": src_address,
        "uuid": uuid,} }

    params[:"static"].each do |k, v|
        if not v 
            params[:"static"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating static') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/inside/source/static/%<src-address>s+%<partition>s"
    nat_address = new_resource.nat_address
    partition = new_resource.partition
    vrid = new_resource.vrid
    src_address = new_resource.src_address
    uuid = new_resource.uuid

    params = { "static": {"nat-address": nat_address,
        "partition": partition,
        "vrid": vrid,
        "src-address": src_address,
        "uuid": uuid,} }

    params[:"static"].each do |k, v|
        if not v
            params[:"static"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["static"].each do |k, v|
        if v != params[:"static"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating static') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/nat/inside/source/static/%<src-address>s+%<partition>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static') do
            client.delete(url)
        end
    end
end