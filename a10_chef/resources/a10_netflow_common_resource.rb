resource_name :a10_netflow_common

property :a10_name, String, name_property: true
property :max_packet_queue_time, Integer
property :reset_time_on_flow_record, [true, false]
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/"
    get_url = "/axapi/v3/netflow/common"
    max_packet_queue_time = new_resource.max_packet_queue_time
    reset_time_on_flow_record = new_resource.reset_time_on_flow_record
    uuid = new_resource.uuid

    params = { "common": {"max-packet-queue-time": max_packet_queue_time,
        "reset-time-on-flow-record": reset_time_on_flow_record,
        "uuid": uuid,} }

    params[:"common"].each do |k, v|
        if not v 
            params[:"common"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating common') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/common"
    max_packet_queue_time = new_resource.max_packet_queue_time
    reset_time_on_flow_record = new_resource.reset_time_on_flow_record
    uuid = new_resource.uuid

    params = { "common": {"max-packet-queue-time": max_packet_queue_time,
        "reset-time-on-flow-record": reset_time_on_flow_record,
        "uuid": uuid,} }

    params[:"common"].each do |k, v|
        if not v
            params[:"common"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["common"].each do |k, v|
        if v != params[:"common"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating common') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/common"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting common') do
            client.delete(url)
        end
    end
end