resource_name :a10_snmp_server_enable_traps_routing_isis

property :a10_name, String, name_property: true
property :isisAuthenticationFailure, [true, false]
property :uuid, String
property :isisProtocolsSupportedMismatch, [true, false]
property :isisRejectedAdjacency, [true, false]
property :isisMaxAreaAddressesMismatch, [true, false]
property :isisCorruptedLSPDetected, [true, false]
property :isisOriginatingLSPBufferSizeMismatch, [true, false]
property :isisAreaMismatch, [true, false]
property :isisLSPTooLargeToPropagate, [true, false]
property :isisOwnLSPPurge, [true, false]
property :isisSequenceNumberSkip, [true, false]
property :isisDatabaseOverload, [true, false]
property :isisAttemptToExceedMaxSequence, [true, false]
property :isisIDLenMismatch, [true, false]
property :isisAuthenticationTypeFailure, [true, false]
property :isisVersionSkew, [true, false]
property :isisManualAddressDrops, [true, false]
property :isisAdjacencyChange, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/snmp-server/enable/traps/routing/"
    get_url = "/axapi/v3/snmp-server/enable/traps/routing/isis"
    isisAuthenticationFailure = new_resource.isisAuthenticationFailure
    uuid = new_resource.uuid
    isisProtocolsSupportedMismatch = new_resource.isisProtocolsSupportedMismatch
    isisRejectedAdjacency = new_resource.isisRejectedAdjacency
    isisMaxAreaAddressesMismatch = new_resource.isisMaxAreaAddressesMismatch
    isisCorruptedLSPDetected = new_resource.isisCorruptedLSPDetected
    isisOriginatingLSPBufferSizeMismatch = new_resource.isisOriginatingLSPBufferSizeMismatch
    isisAreaMismatch = new_resource.isisAreaMismatch
    isisLSPTooLargeToPropagate = new_resource.isisLSPTooLargeToPropagate
    isisOwnLSPPurge = new_resource.isisOwnLSPPurge
    isisSequenceNumberSkip = new_resource.isisSequenceNumberSkip
    isisDatabaseOverload = new_resource.isisDatabaseOverload
    isisAttemptToExceedMaxSequence = new_resource.isisAttemptToExceedMaxSequence
    isisIDLenMismatch = new_resource.isisIDLenMismatch
    isisAuthenticationTypeFailure = new_resource.isisAuthenticationTypeFailure
    isisVersionSkew = new_resource.isisVersionSkew
    isisManualAddressDrops = new_resource.isisManualAddressDrops
    isisAdjacencyChange = new_resource.isisAdjacencyChange

    params = { "isis": {"isisAuthenticationFailure": isisAuthenticationFailure,
        "uuid": uuid,
        "isisProtocolsSupportedMismatch": isisProtocolsSupportedMismatch,
        "isisRejectedAdjacency": isisRejectedAdjacency,
        "isisMaxAreaAddressesMismatch": isisMaxAreaAddressesMismatch,
        "isisCorruptedLSPDetected": isisCorruptedLSPDetected,
        "isisOriginatingLSPBufferSizeMismatch": isisOriginatingLSPBufferSizeMismatch,
        "isisAreaMismatch": isisAreaMismatch,
        "isisLSPTooLargeToPropagate": isisLSPTooLargeToPropagate,
        "isisOwnLSPPurge": isisOwnLSPPurge,
        "isisSequenceNumberSkip": isisSequenceNumberSkip,
        "isisDatabaseOverload": isisDatabaseOverload,
        "isisAttemptToExceedMaxSequence": isisAttemptToExceedMaxSequence,
        "isisIDLenMismatch": isisIDLenMismatch,
        "isisAuthenticationTypeFailure": isisAuthenticationTypeFailure,
        "isisVersionSkew": isisVersionSkew,
        "isisManualAddressDrops": isisManualAddressDrops,
        "isisAdjacencyChange": isisAdjacencyChange,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/routing/isis"
    isisAuthenticationFailure = new_resource.isisAuthenticationFailure
    uuid = new_resource.uuid
    isisProtocolsSupportedMismatch = new_resource.isisProtocolsSupportedMismatch
    isisRejectedAdjacency = new_resource.isisRejectedAdjacency
    isisMaxAreaAddressesMismatch = new_resource.isisMaxAreaAddressesMismatch
    isisCorruptedLSPDetected = new_resource.isisCorruptedLSPDetected
    isisOriginatingLSPBufferSizeMismatch = new_resource.isisOriginatingLSPBufferSizeMismatch
    isisAreaMismatch = new_resource.isisAreaMismatch
    isisLSPTooLargeToPropagate = new_resource.isisLSPTooLargeToPropagate
    isisOwnLSPPurge = new_resource.isisOwnLSPPurge
    isisSequenceNumberSkip = new_resource.isisSequenceNumberSkip
    isisDatabaseOverload = new_resource.isisDatabaseOverload
    isisAttemptToExceedMaxSequence = new_resource.isisAttemptToExceedMaxSequence
    isisIDLenMismatch = new_resource.isisIDLenMismatch
    isisAuthenticationTypeFailure = new_resource.isisAuthenticationTypeFailure
    isisVersionSkew = new_resource.isisVersionSkew
    isisManualAddressDrops = new_resource.isisManualAddressDrops
    isisAdjacencyChange = new_resource.isisAdjacencyChange

    params = { "isis": {"isisAuthenticationFailure": isisAuthenticationFailure,
        "uuid": uuid,
        "isisProtocolsSupportedMismatch": isisProtocolsSupportedMismatch,
        "isisRejectedAdjacency": isisRejectedAdjacency,
        "isisMaxAreaAddressesMismatch": isisMaxAreaAddressesMismatch,
        "isisCorruptedLSPDetected": isisCorruptedLSPDetected,
        "isisOriginatingLSPBufferSizeMismatch": isisOriginatingLSPBufferSizeMismatch,
        "isisAreaMismatch": isisAreaMismatch,
        "isisLSPTooLargeToPropagate": isisLSPTooLargeToPropagate,
        "isisOwnLSPPurge": isisOwnLSPPurge,
        "isisSequenceNumberSkip": isisSequenceNumberSkip,
        "isisDatabaseOverload": isisDatabaseOverload,
        "isisAttemptToExceedMaxSequence": isisAttemptToExceedMaxSequence,
        "isisIDLenMismatch": isisIDLenMismatch,
        "isisAuthenticationTypeFailure": isisAuthenticationTypeFailure,
        "isisVersionSkew": isisVersionSkew,
        "isisManualAddressDrops": isisManualAddressDrops,
        "isisAdjacencyChange": isisAdjacencyChange,} }

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
    url = "/axapi/v3/snmp-server/enable/traps/routing/isis"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting isis') do
            client.delete(url)
        end
    end
end