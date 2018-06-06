resource_name :a10_logging_facility

property :a10_name, String, name_property: true
property :uuid, String
property :facilityname, ['local0','local1','local2','local3','local4','local5','local6','local7']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/logging/"
    get_url = "/axapi/v3/logging/facility"
    uuid = new_resource.uuid
    facilityname = new_resource.facilityname

    params = { "facility": {"uuid": uuid,
        "facilityname": facilityname,} }

    params[:"facility"].each do |k, v|
        if not v 
            params[:"facility"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating facility') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/facility"
    uuid = new_resource.uuid
    facilityname = new_resource.facilityname

    params = { "facility": {"uuid": uuid,
        "facilityname": facilityname,} }

    params[:"facility"].each do |k, v|
        if not v
            params[:"facility"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["facility"].each do |k, v|
        if v != params[:"facility"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating facility') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/logging/facility"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting facility') do
            client.delete(url)
        end
    end
end