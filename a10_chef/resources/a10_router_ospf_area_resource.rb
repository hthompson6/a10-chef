resource_name :a10_router_ospf_area

property :a10_name, String, name_property: true
property :nssa_cfg, Hash
property :uuid, String
property :filter_lists, Array
property :area_num, Integer,required: true
property :virtual_link_list, Array
property :stub_cfg, Hash
property :shortcut, ['default','disable','enable']
property :auth_cfg, Hash
property :range_list, Array
property :default_cost, Integer
property :area_ipv4, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ospf/%<process-id>s/area/"
    get_url = "/axapi/v3/router/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"
    nssa_cfg = new_resource.nssa_cfg
    uuid = new_resource.uuid
    filter_lists = new_resource.filter_lists
    area_num = new_resource.area_num
    virtual_link_list = new_resource.virtual_link_list
    stub_cfg = new_resource.stub_cfg
    shortcut = new_resource.shortcut
    auth_cfg = new_resource.auth_cfg
    range_list = new_resource.range_list
    default_cost = new_resource.default_cost
    area_ipv4 = new_resource.area_ipv4

    params = { "area": {"nssa-cfg": nssa_cfg,
        "uuid": uuid,
        "filter-lists": filter_lists,
        "area-num": area_num,
        "virtual-link-list": virtual_link_list,
        "stub-cfg": stub_cfg,
        "shortcut": shortcut,
        "auth-cfg": auth_cfg,
        "range-list": range_list,
        "default-cost": default_cost,
        "area-ipv4": area_ipv4,} }

    params[:"area"].each do |k, v|
        if not v 
            params[:"area"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating area') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"
    nssa_cfg = new_resource.nssa_cfg
    uuid = new_resource.uuid
    filter_lists = new_resource.filter_lists
    area_num = new_resource.area_num
    virtual_link_list = new_resource.virtual_link_list
    stub_cfg = new_resource.stub_cfg
    shortcut = new_resource.shortcut
    auth_cfg = new_resource.auth_cfg
    range_list = new_resource.range_list
    default_cost = new_resource.default_cost
    area_ipv4 = new_resource.area_ipv4

    params = { "area": {"nssa-cfg": nssa_cfg,
        "uuid": uuid,
        "filter-lists": filter_lists,
        "area-num": area_num,
        "virtual-link-list": virtual_link_list,
        "stub-cfg": stub_cfg,
        "shortcut": shortcut,
        "auth-cfg": auth_cfg,
        "range-list": range_list,
        "default-cost": default_cost,
        "area-ipv4": area_ipv4,} }

    params[:"area"].each do |k, v|
        if not v
            params[:"area"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["area"].each do |k, v|
        if v != params[:"area"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating area') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/router/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting area') do
            client.delete(url)
        end
    end
end