resource_name :a10_netflow_monitor_record

property :a10_name, String, name_property: true
property :sesn_event_fw6, ['both','creation','deletion']
property :sesn_event_nat44, ['both','creation','deletion']
property :nat44, [true, false]
property :sesn_event_nat64, ['both','creation','deletion']
property :nat64, [true, false]
property :port_batch_v2_nat64, ['both','creation','deletion']
property :dslite, [true, false]
property :port_batch_v2_dslite, ['both','creation','deletion']
property :port_batch_nat44, ['both','creation','deletion']
property :netflow_v5_ext, [true, false]
property :port_mapping_nat64, ['both','creation','deletion']
property :sesn_event_dslite, ['both','creation','deletion']
property :port_batch_v2_nat44, ['both','creation','deletion']
property :netflow_v5, [true, false]
property :port_batch_dslite, ['both','creation','deletion']
property :port_mapping_dslite, ['both','creation','deletion']
property :port_mapping_nat44, ['both','creation','deletion']
property :sesn_event_fw4, ['both','creation','deletion']
property :port_batch_nat64, ['both','creation','deletion']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/%<name>s/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s/record"
    sesn_event_fw6 = new_resource.sesn_event_fw6
    sesn_event_nat44 = new_resource.sesn_event_nat44
    nat44 = new_resource.nat44
    sesn_event_nat64 = new_resource.sesn_event_nat64
    nat64 = new_resource.nat64
    port_batch_v2_nat64 = new_resource.port_batch_v2_nat64
    dslite = new_resource.dslite
    port_batch_v2_dslite = new_resource.port_batch_v2_dslite
    port_batch_nat44 = new_resource.port_batch_nat44
    netflow_v5_ext = new_resource.netflow_v5_ext
    port_mapping_nat64 = new_resource.port_mapping_nat64
    sesn_event_dslite = new_resource.sesn_event_dslite
    port_batch_v2_nat44 = new_resource.port_batch_v2_nat44
    netflow_v5 = new_resource.netflow_v5
    port_batch_dslite = new_resource.port_batch_dslite
    port_mapping_dslite = new_resource.port_mapping_dslite
    port_mapping_nat44 = new_resource.port_mapping_nat44
    sesn_event_fw4 = new_resource.sesn_event_fw4
    port_batch_nat64 = new_resource.port_batch_nat64
    uuid = new_resource.uuid

    params = { "record": {"sesn-event-fw6": sesn_event_fw6,
        "sesn-event-nat44": sesn_event_nat44,
        "nat44": nat44,
        "sesn-event-nat64": sesn_event_nat64,
        "nat64": nat64,
        "port-batch-v2-nat64": port_batch_v2_nat64,
        "dslite": dslite,
        "port-batch-v2-dslite": port_batch_v2_dslite,
        "port-batch-nat44": port_batch_nat44,
        "netflow-v5-ext": netflow_v5_ext,
        "port-mapping-nat64": port_mapping_nat64,
        "sesn-event-dslite": sesn_event_dslite,
        "port-batch-v2-nat44": port_batch_v2_nat44,
        "netflow-v5": netflow_v5,
        "port-batch-dslite": port_batch_dslite,
        "port-mapping-dslite": port_mapping_dslite,
        "port-mapping-nat44": port_mapping_nat44,
        "sesn-event-fw4": sesn_event_fw4,
        "port-batch-nat64": port_batch_nat64,
        "uuid": uuid,} }

    params[:"record"].each do |k, v|
        if not v 
            params[:"record"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating record') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/record"
    sesn_event_fw6 = new_resource.sesn_event_fw6
    sesn_event_nat44 = new_resource.sesn_event_nat44
    nat44 = new_resource.nat44
    sesn_event_nat64 = new_resource.sesn_event_nat64
    nat64 = new_resource.nat64
    port_batch_v2_nat64 = new_resource.port_batch_v2_nat64
    dslite = new_resource.dslite
    port_batch_v2_dslite = new_resource.port_batch_v2_dslite
    port_batch_nat44 = new_resource.port_batch_nat44
    netflow_v5_ext = new_resource.netflow_v5_ext
    port_mapping_nat64 = new_resource.port_mapping_nat64
    sesn_event_dslite = new_resource.sesn_event_dslite
    port_batch_v2_nat44 = new_resource.port_batch_v2_nat44
    netflow_v5 = new_resource.netflow_v5
    port_batch_dslite = new_resource.port_batch_dslite
    port_mapping_dslite = new_resource.port_mapping_dslite
    port_mapping_nat44 = new_resource.port_mapping_nat44
    sesn_event_fw4 = new_resource.sesn_event_fw4
    port_batch_nat64 = new_resource.port_batch_nat64
    uuid = new_resource.uuid

    params = { "record": {"sesn-event-fw6": sesn_event_fw6,
        "sesn-event-nat44": sesn_event_nat44,
        "nat44": nat44,
        "sesn-event-nat64": sesn_event_nat64,
        "nat64": nat64,
        "port-batch-v2-nat64": port_batch_v2_nat64,
        "dslite": dslite,
        "port-batch-v2-dslite": port_batch_v2_dslite,
        "port-batch-nat44": port_batch_nat44,
        "netflow-v5-ext": netflow_v5_ext,
        "port-mapping-nat64": port_mapping_nat64,
        "sesn-event-dslite": sesn_event_dslite,
        "port-batch-v2-nat44": port_batch_v2_nat44,
        "netflow-v5": netflow_v5,
        "port-batch-dslite": port_batch_dslite,
        "port-mapping-dslite": port_mapping_dslite,
        "port-mapping-nat44": port_mapping_nat44,
        "sesn-event-fw4": sesn_event_fw4,
        "port-batch-nat64": port_batch_nat64,
        "uuid": uuid,} }

    params[:"record"].each do |k, v|
        if not v
            params[:"record"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["record"].each do |k, v|
        if v != params[:"record"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating record') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s/record"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting record') do
            client.delete(url)
        end
    end
end