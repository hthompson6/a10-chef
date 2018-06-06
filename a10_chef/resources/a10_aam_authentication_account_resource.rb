resource_name :a10_aam_authentication_account

property :a10_name, String, name_property: true
property :sampling_enable, Array
property :kerberos_spn_list, Array
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/"
    get_url = "/axapi/v3/aam/authentication/account"
    sampling_enable = new_resource.sampling_enable
    kerberos_spn_list = new_resource.kerberos_spn_list
    uuid = new_resource.uuid

    params = { "account": {"sampling-enable": sampling_enable,
        "kerberos-spn-list": kerberos_spn_list,
        "uuid": uuid,} }

    params[:"account"].each do |k, v|
        if not v 
            params[:"account"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating account') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/account"
    sampling_enable = new_resource.sampling_enable
    kerberos_spn_list = new_resource.kerberos_spn_list
    uuid = new_resource.uuid

    params = { "account": {"sampling-enable": sampling_enable,
        "kerberos-spn-list": kerberos_spn_list,
        "uuid": uuid,} }

    params[:"account"].each do |k, v|
        if not v
            params[:"account"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["account"].each do |k, v|
        if v != params[:"account"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating account') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/account"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting account') do
            client.delete(url)
        end
    end
end