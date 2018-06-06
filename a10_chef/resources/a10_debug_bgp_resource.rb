resource_name :a10_debug_bgp

property :a10_name, String, name_property: true
property :all, [true, false]
property :dampening, [true, false]
property :nsm, [true, false]
property :bfd, [true, false]
property :fsm, [true, false]
property :nht, [true, false]
property :updates, [true, false]
property :filters, [true, false]
property :nin, [true, false]
property :keepalives, [true, false]
property :out, [true, false]
property :a10_events, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/bgp"
    all = new_resource.all
    dampening = new_resource.dampening
    nsm = new_resource.nsm
    bfd = new_resource.bfd
    fsm = new_resource.fsm
    nht = new_resource.nht
    updates = new_resource.updates
    filters = new_resource.filters
    nin = new_resource.nin
    keepalives = new_resource.keepalives
    out = new_resource.out
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "bgp": {"all": all,
        "dampening": dampening,
        "nsm": nsm,
        "bfd": bfd,
        "fsm": fsm,
        "nht": nht,
        "updates": updates,
        "filters": filters,
        "in": nin,
        "keepalives": keepalives,
        "out": out,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"bgp"].each do |k, v|
        if not v 
            params[:"bgp"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating bgp') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/bgp"
    all = new_resource.all
    dampening = new_resource.dampening
    nsm = new_resource.nsm
    bfd = new_resource.bfd
    fsm = new_resource.fsm
    nht = new_resource.nht
    updates = new_resource.updates
    filters = new_resource.filters
    nin = new_resource.nin
    keepalives = new_resource.keepalives
    out = new_resource.out
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "bgp": {"all": all,
        "dampening": dampening,
        "nsm": nsm,
        "bfd": bfd,
        "fsm": fsm,
        "nht": nht,
        "updates": updates,
        "filters": filters,
        "in": nin,
        "keepalives": keepalives,
        "out": out,
        "events": a10_events,
        "uuid": uuid,} }

    params[:"bgp"].each do |k, v|
        if not v
            params[:"bgp"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["bgp"].each do |k, v|
        if v != params[:"bgp"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating bgp') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/bgp"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting bgp') do
            client.delete(url)
        end
    end
end