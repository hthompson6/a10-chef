resource_name :a10_snmp_server_enable_traps_routing_ospf

property :a10_name, String, name_property: true
property :ospfLsdbOverflow, [true, false]
property :uuid, String
property :ospfNbrStateChange, [true, false]
property :ospfIfStateChange, [true, false]
property :ospfVirtNbrStateChange, [true, false]
property :ospfLsdbApproachingOverflow, [true, false]
property :ospfIfAuthFailure, [true, false]
property :ospfVirtIfAuthFailure, [true, false]
property :ospfVirtIfConfigError, [true, false]
property :ospfVirtIfRxBadPacket, [true, false]
property :ospfTxRetransmit, [true, false]
property :ospfVirtIfStateChange, [true, false]
property :ospfIfConfigError, [true, false]
property :ospfMaxAgeLsa, [true, false]
property :ospfIfRxBadPacket, [true, false]
property :ospfVirtIfTxRetransmit, [true, false]
property :ospfOriginateLsa, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/routing/"
    get_url = "/axapi/v3/snmp-server/enable/traps/routing/ospf"
    ospfLsdbOverflow = new_resource.ospfLsdbOverflow
    uuid = new_resource.uuid
    ospfNbrStateChange = new_resource.ospfNbrStateChange
    ospfIfStateChange = new_resource.ospfIfStateChange
    ospfVirtNbrStateChange = new_resource.ospfVirtNbrStateChange
    ospfLsdbApproachingOverflow = new_resource.ospfLsdbApproachingOverflow
    ospfIfAuthFailure = new_resource.ospfIfAuthFailure
    ospfVirtIfAuthFailure = new_resource.ospfVirtIfAuthFailure
    ospfVirtIfConfigError = new_resource.ospfVirtIfConfigError
    ospfVirtIfRxBadPacket = new_resource.ospfVirtIfRxBadPacket
    ospfTxRetransmit = new_resource.ospfTxRetransmit
    ospfVirtIfStateChange = new_resource.ospfVirtIfStateChange
    ospfIfConfigError = new_resource.ospfIfConfigError
    ospfMaxAgeLsa = new_resource.ospfMaxAgeLsa
    ospfIfRxBadPacket = new_resource.ospfIfRxBadPacket
    ospfVirtIfTxRetransmit = new_resource.ospfVirtIfTxRetransmit
    ospfOriginateLsa = new_resource.ospfOriginateLsa

    params = { "ospf": {"ospfLsdbOverflow": ospfLsdbOverflow,
        "uuid": uuid,
        "ospfNbrStateChange": ospfNbrStateChange,
        "ospfIfStateChange": ospfIfStateChange,
        "ospfVirtNbrStateChange": ospfVirtNbrStateChange,
        "ospfLsdbApproachingOverflow": ospfLsdbApproachingOverflow,
        "ospfIfAuthFailure": ospfIfAuthFailure,
        "ospfVirtIfAuthFailure": ospfVirtIfAuthFailure,
        "ospfVirtIfConfigError": ospfVirtIfConfigError,
        "ospfVirtIfRxBadPacket": ospfVirtIfRxBadPacket,
        "ospfTxRetransmit": ospfTxRetransmit,
        "ospfVirtIfStateChange": ospfVirtIfStateChange,
        "ospfIfConfigError": ospfIfConfigError,
        "ospfMaxAgeLsa": ospfMaxAgeLsa,
        "ospfIfRxBadPacket": ospfIfRxBadPacket,
        "ospfVirtIfTxRetransmit": ospfVirtIfTxRetransmit,
        "ospfOriginateLsa": ospfOriginateLsa,} }

    params[:"ospf"].each do |k, v|
        if not v 
            params[:"ospf"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ospf') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/routing/ospf"
    ospfLsdbOverflow = new_resource.ospfLsdbOverflow
    uuid = new_resource.uuid
    ospfNbrStateChange = new_resource.ospfNbrStateChange
    ospfIfStateChange = new_resource.ospfIfStateChange
    ospfVirtNbrStateChange = new_resource.ospfVirtNbrStateChange
    ospfLsdbApproachingOverflow = new_resource.ospfLsdbApproachingOverflow
    ospfIfAuthFailure = new_resource.ospfIfAuthFailure
    ospfVirtIfAuthFailure = new_resource.ospfVirtIfAuthFailure
    ospfVirtIfConfigError = new_resource.ospfVirtIfConfigError
    ospfVirtIfRxBadPacket = new_resource.ospfVirtIfRxBadPacket
    ospfTxRetransmit = new_resource.ospfTxRetransmit
    ospfVirtIfStateChange = new_resource.ospfVirtIfStateChange
    ospfIfConfigError = new_resource.ospfIfConfigError
    ospfMaxAgeLsa = new_resource.ospfMaxAgeLsa
    ospfIfRxBadPacket = new_resource.ospfIfRxBadPacket
    ospfVirtIfTxRetransmit = new_resource.ospfVirtIfTxRetransmit
    ospfOriginateLsa = new_resource.ospfOriginateLsa

    params = { "ospf": {"ospfLsdbOverflow": ospfLsdbOverflow,
        "uuid": uuid,
        "ospfNbrStateChange": ospfNbrStateChange,
        "ospfIfStateChange": ospfIfStateChange,
        "ospfVirtNbrStateChange": ospfVirtNbrStateChange,
        "ospfLsdbApproachingOverflow": ospfLsdbApproachingOverflow,
        "ospfIfAuthFailure": ospfIfAuthFailure,
        "ospfVirtIfAuthFailure": ospfVirtIfAuthFailure,
        "ospfVirtIfConfigError": ospfVirtIfConfigError,
        "ospfVirtIfRxBadPacket": ospfVirtIfRxBadPacket,
        "ospfTxRetransmit": ospfTxRetransmit,
        "ospfVirtIfStateChange": ospfVirtIfStateChange,
        "ospfIfConfigError": ospfIfConfigError,
        "ospfMaxAgeLsa": ospfMaxAgeLsa,
        "ospfIfRxBadPacket": ospfIfRxBadPacket,
        "ospfVirtIfTxRetransmit": ospfVirtIfTxRetransmit,
        "ospfOriginateLsa": ospfOriginateLsa,} }

    params[:"ospf"].each do |k, v|
        if not v
            params[:"ospf"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ospf"].each do |k, v|
        if v != params[:"ospf"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ospf') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/snmp-server/enable/traps/routing/ospf"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ospf') do
            client.delete(url)
        end
    end
end