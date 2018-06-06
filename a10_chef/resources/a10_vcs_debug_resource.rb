resource_name :a10_vcs_debug

property :a10_name, String, name_property: true
property :info, [true, false]
property :daemon_msg, [true, false]
property :daemon, [true, false]
property :lib, [true, false]
property :vblade, [true, false]
property :election_pdu, [true, false]
property :util, [true, false]
property :ssl, [true, false]
property :handler, [true, false]
property :election, [true, false]
property :vmaster, [true, false]
property :vblade_msg, [true, false]
property :net, [true, false]
property :encoder, [true, false]
property :vmaster_msg, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vcs/"
    get_url = "/axapi/v3/vcs/debug"
    info = new_resource.info
    daemon_msg = new_resource.daemon_msg
    daemon = new_resource.daemon
    lib = new_resource.lib
    vblade = new_resource.vblade
    election_pdu = new_resource.election_pdu
    util = new_resource.util
    ssl = new_resource.ssl
    handler = new_resource.handler
    election = new_resource.election
    vmaster = new_resource.vmaster
    vblade_msg = new_resource.vblade_msg
    net = new_resource.net
    encoder = new_resource.encoder
    vmaster_msg = new_resource.vmaster_msg

    params = { "debug": {"info": info,
        "daemon_msg": daemon_msg,
        "daemon": daemon,
        "lib": lib,
        "vblade": vblade,
        "election_pdu": election_pdu,
        "util": util,
        "ssl": ssl,
        "handler": handler,
        "election": election,
        "vmaster": vmaster,
        "vblade_msg": vblade_msg,
        "net": net,
        "encoder": encoder,
        "vmaster_msg": vmaster_msg,} }

    params[:"debug"].each do |k, v|
        if not v 
            params[:"debug"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating debug') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/debug"
    info = new_resource.info
    daemon_msg = new_resource.daemon_msg
    daemon = new_resource.daemon
    lib = new_resource.lib
    vblade = new_resource.vblade
    election_pdu = new_resource.election_pdu
    util = new_resource.util
    ssl = new_resource.ssl
    handler = new_resource.handler
    election = new_resource.election
    vmaster = new_resource.vmaster
    vblade_msg = new_resource.vblade_msg
    net = new_resource.net
    encoder = new_resource.encoder
    vmaster_msg = new_resource.vmaster_msg

    params = { "debug": {"info": info,
        "daemon_msg": daemon_msg,
        "daemon": daemon,
        "lib": lib,
        "vblade": vblade,
        "election_pdu": election_pdu,
        "util": util,
        "ssl": ssl,
        "handler": handler,
        "election": election,
        "vmaster": vmaster,
        "vblade_msg": vblade_msg,
        "net": net,
        "encoder": encoder,
        "vmaster_msg": vmaster_msg,} }

    params[:"debug"].each do |k, v|
        if not v
            params[:"debug"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["debug"].each do |k, v|
        if v != params[:"debug"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating debug') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vcs/debug"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting debug') do
            client.delete(url)
        end
    end
end