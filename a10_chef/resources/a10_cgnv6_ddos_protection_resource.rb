resource_name :a10_cgnv6_ddos_protection

property :a10_name, String, name_property: true
property :logging, Hash
property :uuid, String
property :zone, String
property :sampling_enable, Array
property :toggle, ['enable','disable']
property :max_hw_entries, Integer
property :packets_per_second, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/"
    get_url = "/axapi/v3/cgnv6/ddos-protection"
    logging = new_resource.logging
    uuid = new_resource.uuid
    zone = new_resource.zone
    sampling_enable = new_resource.sampling_enable
    toggle = new_resource.toggle
    max_hw_entries = new_resource.max_hw_entries
    packets_per_second = new_resource.packets_per_second

    params = { "ddos-protection": {"logging": logging,
        "uuid": uuid,
        "zone": zone,
        "sampling-enable": sampling_enable,
        "toggle": toggle,
        "max-hw-entries": max_hw_entries,
        "packets-per-second": packets_per_second,} }

    params[:"ddos-protection"].each do |k, v|
        if not v 
            params[:"ddos-protection"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating ddos-protection') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ddos-protection"
    logging = new_resource.logging
    uuid = new_resource.uuid
    zone = new_resource.zone
    sampling_enable = new_resource.sampling_enable
    toggle = new_resource.toggle
    max_hw_entries = new_resource.max_hw_entries
    packets_per_second = new_resource.packets_per_second

    params = { "ddos-protection": {"logging": logging,
        "uuid": uuid,
        "zone": zone,
        "sampling-enable": sampling_enable,
        "toggle": toggle,
        "max-hw-entries": max_hw_entries,
        "packets-per-second": packets_per_second,} }

    params[:"ddos-protection"].each do |k, v|
        if not v
            params[:"ddos-protection"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["ddos-protection"].each do |k, v|
        if v != params[:"ddos-protection"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating ddos-protection') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/ddos-protection"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting ddos-protection') do
            client.delete(url)
        end
    end
end