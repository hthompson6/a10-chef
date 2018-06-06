resource_name :a10_ip_nat_inside_source_static

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String
property :vrid, Integer
property :enable_disable_action, ['enable','disable']
property :nat_address, String,required: true
property :disable, [true, false]
property :src_address, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/ip/nat/inside/source/static/"
    get_url = "/axapi/v3/ip/nat/inside/source/static/%<src-address>s+%<nat-address>s"
    enable = new_resource.enable
    uuid = new_resource.uuid
    vrid = new_resource.vrid
    enable_disable_action = new_resource.enable_disable_action
    nat_address = new_resource.nat_address
    disable = new_resource.disable
    src_address = new_resource.src_address

    params = { "static": {"enable": enable,
        "uuid": uuid,
        "vrid": vrid,
        "enable-disable-action": enable_disable_action,
        "nat-address": nat_address,
        "disable": disable,
        "src-address": src_address,} }

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
    url = "/axapi/v3/ip/nat/inside/source/static/%<src-address>s+%<nat-address>s"
    enable = new_resource.enable
    uuid = new_resource.uuid
    vrid = new_resource.vrid
    enable_disable_action = new_resource.enable_disable_action
    nat_address = new_resource.nat_address
    disable = new_resource.disable
    src_address = new_resource.src_address

    params = { "static": {"enable": enable,
        "uuid": uuid,
        "vrid": vrid,
        "enable-disable-action": enable_disable_action,
        "nat-address": nat_address,
        "disable": disable,
        "src-address": src_address,} }

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
    url = "/axapi/v3/ip/nat/inside/source/static/%<src-address>s+%<nat-address>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting static') do
            client.delete(url)
        end
    end
end