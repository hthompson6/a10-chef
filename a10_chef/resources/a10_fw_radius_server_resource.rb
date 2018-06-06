resource_name :a10_fw_radius_server

property :a10_name, String, name_property: true
property :accounting_start, ['ignore','append-entry','replace-entry']
property :attribute_name, ['msisdn','imei','imsi']
property :vrid, Integer
property :remote, Hash
property :uuid, String
property :encrypted, String
property :accounting_interim_update, ['ignore','append-entry','replace-entry']
property :secret, [true, false]
property :sampling_enable, Array
property :accounting_stop, ['ignore','delete-entry']
property :custom_attribute_name, String
property :attribute, Array
property :listen_port, Integer
property :accounting_on, ['ignore','delete-entries-using-attribute']
property :secret_string, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/fw/radius/"
    get_url = "/axapi/v3/fw/radius/server"
    accounting_start = new_resource.accounting_start
    attribute_name = new_resource.attribute_name
    vrid = new_resource.vrid
    remote = new_resource.remote
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    accounting_interim_update = new_resource.accounting_interim_update
    secret = new_resource.secret
    sampling_enable = new_resource.sampling_enable
    accounting_stop = new_resource.accounting_stop
    custom_attribute_name = new_resource.custom_attribute_name
    attribute = new_resource.attribute
    listen_port = new_resource.listen_port
    accounting_on = new_resource.accounting_on
    secret_string = new_resource.secret_string

    params = { "server": {"accounting-start": accounting_start,
        "attribute-name": attribute_name,
        "vrid": vrid,
        "remote": remote,
        "uuid": uuid,
        "encrypted": encrypted,
        "accounting-interim-update": accounting_interim_update,
        "secret": secret,
        "sampling-enable": sampling_enable,
        "accounting-stop": accounting_stop,
        "custom-attribute-name": custom_attribute_name,
        "attribute": attribute,
        "listen-port": listen_port,
        "accounting-on": accounting_on,
        "secret-string": secret_string,} }

    params[:"server"].each do |k, v|
        if not v 
            params[:"server"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating server') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/radius/server"
    accounting_start = new_resource.accounting_start
    attribute_name = new_resource.attribute_name
    vrid = new_resource.vrid
    remote = new_resource.remote
    uuid = new_resource.uuid
    encrypted = new_resource.encrypted
    accounting_interim_update = new_resource.accounting_interim_update
    secret = new_resource.secret
    sampling_enable = new_resource.sampling_enable
    accounting_stop = new_resource.accounting_stop
    custom_attribute_name = new_resource.custom_attribute_name
    attribute = new_resource.attribute
    listen_port = new_resource.listen_port
    accounting_on = new_resource.accounting_on
    secret_string = new_resource.secret_string

    params = { "server": {"accounting-start": accounting_start,
        "attribute-name": attribute_name,
        "vrid": vrid,
        "remote": remote,
        "uuid": uuid,
        "encrypted": encrypted,
        "accounting-interim-update": accounting_interim_update,
        "secret": secret,
        "sampling-enable": sampling_enable,
        "accounting-stop": accounting_stop,
        "custom-attribute-name": custom_attribute_name,
        "attribute": attribute,
        "listen-port": listen_port,
        "accounting-on": accounting_on,
        "secret-string": secret_string,} }

    params[:"server"].each do |k, v|
        if not v
            params[:"server"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["server"].each do |k, v|
        if v != params[:"server"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating server') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/fw/radius/server"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting server') do
            client.delete(url)
        end
    end
end