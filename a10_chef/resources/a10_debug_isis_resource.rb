resource_name :a10_debug_isis

property :a10_name, String, name_property: true
property :all, [true, false]
property :uuid, String
property :bfd, [true, false]
property :pdu, [true, false]
property :nfsm, [true, false]
property :nsm, [true, false]
property :lsp, [true, false]
property :a10_events, [true, false]
property :spf, [true, false]
property :ifsm, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/isis"
    all = new_resource.all
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    pdu = new_resource.pdu
    nfsm = new_resource.nfsm
    nsm = new_resource.nsm
    lsp = new_resource.lsp
    a10_name = new_resource.a10_name
    spf = new_resource.spf
    ifsm = new_resource.ifsm

    params = { "isis": {"all": all,
        "uuid": uuid,
        "bfd": bfd,
        "pdu": pdu,
        "nfsm": nfsm,
        "nsm": nsm,
        "lsp": lsp,
        "events": a10_events,
        "spf": spf,
        "ifsm": ifsm,} }

    params[:"isis"].each do |k, v|
        if not v 
            params[:"isis"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating isis') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/isis"
    all = new_resource.all
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    pdu = new_resource.pdu
    nfsm = new_resource.nfsm
    nsm = new_resource.nsm
    lsp = new_resource.lsp
    a10_name = new_resource.a10_name
    spf = new_resource.spf
    ifsm = new_resource.ifsm

    params = { "isis": {"all": all,
        "uuid": uuid,
        "bfd": bfd,
        "pdu": pdu,
        "nfsm": nfsm,
        "nsm": nsm,
        "lsp": lsp,
        "events": a10_events,
        "spf": spf,
        "ifsm": ifsm,} }

    params[:"isis"].each do |k, v|
        if not v
            params[:"isis"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["isis"].each do |k, v|
        if v != params[:"isis"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating isis') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/isis"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting isis') do
            client.delete(url)
        end
    end
end