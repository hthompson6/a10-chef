resource_name :a10_netflow_monitor

property :a10_name, String, name_property: true
property :disable_log_by_destination, Hash
property :source_ip_use_mgmt, [true, false]
property :protocol, ['v9','v10']
property :source_address, Hash
property :destination, Hash
property :user_tag, String
property :sample, Hash
property :record, Hash
property :sampling_enable, Array
property :disable, [true, false]
property :resend_template, Hash
property :flow_timeout, Integer
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/netflow/monitor/"
    get_url = "/axapi/v3/netflow/monitor/%<name>s"
    disable_log_by_destination = new_resource.disable_log_by_destination
    source_ip_use_mgmt = new_resource.source_ip_use_mgmt
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    source_address = new_resource.source_address
    destination = new_resource.destination
    user_tag = new_resource.user_tag
    sample = new_resource.sample
    record = new_resource.record
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    resend_template = new_resource.resend_template
    flow_timeout = new_resource.flow_timeout
    uuid = new_resource.uuid

    params = { "monitor": {"disable-log-by-destination": disable_log_by_destination,
        "source-ip-use-mgmt": source_ip_use_mgmt,
        "protocol": protocol,
        "name": a10_name,
        "source-address": source_address,
        "destination": destination,
        "user-tag": user_tag,
        "sample": sample,
        "record": record,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "resend-template": resend_template,
        "flow-timeout": flow_timeout,
        "uuid": uuid,} }

    params[:"monitor"].each do |k, v|
        if not v 
            params[:"monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s"
    disable_log_by_destination = new_resource.disable_log_by_destination
    source_ip_use_mgmt = new_resource.source_ip_use_mgmt
    protocol = new_resource.protocol
    a10_name = new_resource.a10_name
    source_address = new_resource.source_address
    destination = new_resource.destination
    user_tag = new_resource.user_tag
    sample = new_resource.sample
    record = new_resource.record
    sampling_enable = new_resource.sampling_enable
    disable = new_resource.disable
    resend_template = new_resource.resend_template
    flow_timeout = new_resource.flow_timeout
    uuid = new_resource.uuid

    params = { "monitor": {"disable-log-by-destination": disable_log_by_destination,
        "source-ip-use-mgmt": source_ip_use_mgmt,
        "protocol": protocol,
        "name": a10_name,
        "source-address": source_address,
        "destination": destination,
        "user-tag": user_tag,
        "sample": sample,
        "record": record,
        "sampling-enable": sampling_enable,
        "disable": disable,
        "resend-template": resend_template,
        "flow-timeout": flow_timeout,
        "uuid": uuid,} }

    params[:"monitor"].each do |k, v|
        if not v
            params[:"monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["monitor"].each do |k, v|
        if v != params[:"monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/netflow/monitor/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting monitor') do
            client.delete(url)
        end
    end
end