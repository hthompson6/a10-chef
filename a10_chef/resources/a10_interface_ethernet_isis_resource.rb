resource_name :a10_interface_ethernet_isis

property :a10_name, String, name_property: true
property :priority_list, Array
property :padding, [true, false]
property :hello_interval_minimal_list, Array
property :mesh_group, Hash
property :network, ['broadcast','point-to-point']
property :authentication, Hash
property :csnp_interval_list, Array
property :retransmit_interval, Integer
property :password_list, Array
property :bfd_cfg, Hash
property :wide_metric_list, Array
property :hello_interval_list, Array
property :circuit_type, ['level-1','level-1-2','level-2-only']
property :hello_multiplier_list, Array
property :metric_list, Array
property :lsp_interval, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/ethernet/%<ifnum>s/"
    get_url = "/axapi/v3/interface/ethernet/%<ifnum>s/isis"
    priority_list = new_resource.priority_list
    padding = new_resource.padding
    hello_interval_minimal_list = new_resource.hello_interval_minimal_list
    mesh_group = new_resource.mesh_group
    network = new_resource.network
    authentication = new_resource.authentication
    csnp_interval_list = new_resource.csnp_interval_list
    retransmit_interval = new_resource.retransmit_interval
    password_list = new_resource.password_list
    bfd_cfg = new_resource.bfd_cfg
    wide_metric_list = new_resource.wide_metric_list
    hello_interval_list = new_resource.hello_interval_list
    circuit_type = new_resource.circuit_type
    hello_multiplier_list = new_resource.hello_multiplier_list
    metric_list = new_resource.metric_list
    lsp_interval = new_resource.lsp_interval
    uuid = new_resource.uuid

    params = { "isis": {"priority-list": priority_list,
        "padding": padding,
        "hello-interval-minimal-list": hello_interval_minimal_list,
        "mesh-group": mesh_group,
        "network": network,
        "authentication": authentication,
        "csnp-interval-list": csnp_interval_list,
        "retransmit-interval": retransmit_interval,
        "password-list": password_list,
        "bfd-cfg": bfd_cfg,
        "wide-metric-list": wide_metric_list,
        "hello-interval-list": hello_interval_list,
        "circuit-type": circuit_type,
        "hello-multiplier-list": hello_multiplier_list,
        "metric-list": metric_list,
        "lsp-interval": lsp_interval,
        "uuid": uuid,} }

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
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/isis"
    priority_list = new_resource.priority_list
    padding = new_resource.padding
    hello_interval_minimal_list = new_resource.hello_interval_minimal_list
    mesh_group = new_resource.mesh_group
    network = new_resource.network
    authentication = new_resource.authentication
    csnp_interval_list = new_resource.csnp_interval_list
    retransmit_interval = new_resource.retransmit_interval
    password_list = new_resource.password_list
    bfd_cfg = new_resource.bfd_cfg
    wide_metric_list = new_resource.wide_metric_list
    hello_interval_list = new_resource.hello_interval_list
    circuit_type = new_resource.circuit_type
    hello_multiplier_list = new_resource.hello_multiplier_list
    metric_list = new_resource.metric_list
    lsp_interval = new_resource.lsp_interval
    uuid = new_resource.uuid

    params = { "isis": {"priority-list": priority_list,
        "padding": padding,
        "hello-interval-minimal-list": hello_interval_minimal_list,
        "mesh-group": mesh_group,
        "network": network,
        "authentication": authentication,
        "csnp-interval-list": csnp_interval_list,
        "retransmit-interval": retransmit_interval,
        "password-list": password_list,
        "bfd-cfg": bfd_cfg,
        "wide-metric-list": wide_metric_list,
        "hello-interval-list": hello_interval_list,
        "circuit-type": circuit_type,
        "hello-multiplier-list": hello_multiplier_list,
        "metric-list": metric_list,
        "lsp-interval": lsp_interval,
        "uuid": uuid,} }

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
    url = "/axapi/v3/interface/ethernet/%<ifnum>s/isis"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting isis') do
            client.delete(url)
        end
    end
end