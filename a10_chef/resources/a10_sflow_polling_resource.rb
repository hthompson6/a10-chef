resource_name :a10_sflow_polling

property :a10_name, String, name_property: true
property :cpu_usage, [true, false]
property :eth_list, Array
property :ve_list, Array
property :uuid, String
property :http_counter, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/sflow/"
    get_url = "/axapi/v3/sflow/polling"
    cpu_usage = new_resource.cpu_usage
    eth_list = new_resource.eth_list
    ve_list = new_resource.ve_list
    uuid = new_resource.uuid
    http_counter = new_resource.http_counter

    params = { "polling": {"cpu-usage": cpu_usage,
        "eth-list": eth_list,
        "ve-list": ve_list,
        "uuid": uuid,
        "http-counter": http_counter,} }

    params[:"polling"].each do |k, v|
        if not v 
            params[:"polling"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating polling') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sflow/polling"
    cpu_usage = new_resource.cpu_usage
    eth_list = new_resource.eth_list
    ve_list = new_resource.ve_list
    uuid = new_resource.uuid
    http_counter = new_resource.http_counter

    params = { "polling": {"cpu-usage": cpu_usage,
        "eth-list": eth_list,
        "ve-list": ve_list,
        "uuid": uuid,
        "http-counter": http_counter,} }

    params[:"polling"].each do |k, v|
        if not v
            params[:"polling"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["polling"].each do |k, v|
        if v != params[:"polling"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating polling') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/sflow/polling"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting polling') do
            client.delete(url)
        end
    end
end