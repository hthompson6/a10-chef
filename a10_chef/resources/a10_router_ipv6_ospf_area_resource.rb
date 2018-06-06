resource_name :a10_router_ipv6_ospf_area

property :a10_name, String, name_property: true
property :uuid, String
property :area_ipv4, String,required: true
property :virtual_link_list, Array
property :stub, [true, false]
property :area_num, Integer,required: true
property :range_list, Array
property :default_cost, Integer
property :no_summary, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/router/ipv6/ospf/%<process-id>s/area/"
    get_url = "/axapi/v3/router/ipv6/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"
    uuid = new_resource.uuid
    area_ipv4 = new_resource.area_ipv4
    virtual_link_list = new_resource.virtual_link_list
    stub = new_resource.stub
    area_num = new_resource.area_num
    range_list = new_resource.range_list
    default_cost = new_resource.default_cost
    no_summary = new_resource.no_summary

    params = { "area": {"uuid": uuid,
        "area-ipv4": area_ipv4,
        "virtual-link-list": virtual_link_list,
        "stub": stub,
        "area-num": area_num,
        "range-list": range_list,
        "default-cost": default_cost,
        "no-summary": no_summary,} }

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
    url = "/axapi/v3/router/ipv6/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"
    uuid = new_resource.uuid
    area_ipv4 = new_resource.area_ipv4
    virtual_link_list = new_resource.virtual_link_list
    stub = new_resource.stub
    area_num = new_resource.area_num
    range_list = new_resource.range_list
    default_cost = new_resource.default_cost
    no_summary = new_resource.no_summary

    params = { "area": {"uuid": uuid,
        "area-ipv4": area_ipv4,
        "virtual-link-list": virtual_link_list,
        "stub": stub,
        "area-num": area_num,
        "range-list": range_list,
        "default-cost": default_cost,
        "no-summary": no_summary,} }

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
    url = "/axapi/v3/router/ipv6/ospf/%<process-id>s/area/%<area-ipv4>s+%<area-num>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting area') do
            client.delete(url)
        end
    end
end