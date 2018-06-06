resource_name :a10_debug_lb

property :a10_name, String, name_property: true
property :all, [true, false]
property :uuid, String
property :cfg, [true, false]
property :flow, [true, false]
property :clb, [true, false]
property :fwlb, [true, false]
property :llb, [true, false]
property :slb, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/lb"
    all = new_resource.all
    uuid = new_resource.uuid
    cfg = new_resource.cfg
    flow = new_resource.flow
    clb = new_resource.clb
    fwlb = new_resource.fwlb
    llb = new_resource.llb
    slb = new_resource.slb

    params = { "lb": {"all": all,
        "uuid": uuid,
        "cfg": cfg,
        "flow": flow,
        "clb": clb,
        "fwlb": fwlb,
        "llb": llb,
        "slb": slb,} }

    params[:"lb"].each do |k, v|
        if not v 
            params[:"lb"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lb') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/lb"
    all = new_resource.all
    uuid = new_resource.uuid
    cfg = new_resource.cfg
    flow = new_resource.flow
    clb = new_resource.clb
    fwlb = new_resource.fwlb
    llb = new_resource.llb
    slb = new_resource.slb

    params = { "lb": {"all": all,
        "uuid": uuid,
        "cfg": cfg,
        "flow": flow,
        "clb": clb,
        "fwlb": fwlb,
        "llb": llb,
        "slb": slb,} }

    params[:"lb"].each do |k, v|
        if not v
            params[:"lb"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lb"].each do |k, v|
        if v != params[:"lb"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lb') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/lb"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lb') do
            client.delete(url)
        end
    end
end