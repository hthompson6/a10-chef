resource_name :a10_aam_authentication_log

property :a10_name, String, name_property: true
property :enable, [true, false]
property :uuid, String
property :facility, ['local0','local1','local2','local3','local4','local5','local6','local7']

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/"
    get_url = "/axapi/v3/aam/authentication/log"
    enable = new_resource.enable
    uuid = new_resource.uuid
    facility = new_resource.facility

    params = { "log": {"enable": enable,
        "uuid": uuid,
        "facility": facility,} }

    params[:"log"].each do |k, v|
        if not v 
            params[:"log"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating log') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/log"
    enable = new_resource.enable
    uuid = new_resource.uuid
    facility = new_resource.facility

    params = { "log": {"enable": enable,
        "uuid": uuid,
        "facility": facility,} }

    params[:"log"].each do |k, v|
        if not v
            params[:"log"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["log"].each do |k, v|
        if v != params[:"log"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating log') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/log"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting log') do
            client.delete(url)
        end
    end
end