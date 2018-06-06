resource_name :a10_aam_authentication_saml_metadata_monitor

property :a10_name, String, name_property: true
property :status, ['enable','disable']
property :acs_continuous_fail_threshold, Integer
property :acs_missing_period, Integer
property :uuid, String
property :acs_missing_threshold, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/saml/"
    get_url = "/axapi/v3/aam/authentication/saml/metadata-monitor"
    status = new_resource.status
    acs_continuous_fail_threshold = new_resource.acs_continuous_fail_threshold
    acs_missing_period = new_resource.acs_missing_period
    uuid = new_resource.uuid
    acs_missing_threshold = new_resource.acs_missing_threshold

    params = { "metadata-monitor": {"status": status,
        "acs-continuous-fail-threshold": acs_continuous_fail_threshold,
        "acs-missing-period": acs_missing_period,
        "uuid": uuid,
        "acs-missing-threshold": acs_missing_threshold,} }

    params[:"metadata-monitor"].each do |k, v|
        if not v 
            params[:"metadata-monitor"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating metadata-monitor') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/metadata-monitor"
    status = new_resource.status
    acs_continuous_fail_threshold = new_resource.acs_continuous_fail_threshold
    acs_missing_period = new_resource.acs_missing_period
    uuid = new_resource.uuid
    acs_missing_threshold = new_resource.acs_missing_threshold

    params = { "metadata-monitor": {"status": status,
        "acs-continuous-fail-threshold": acs_continuous_fail_threshold,
        "acs-missing-period": acs_missing_period,
        "uuid": uuid,
        "acs-missing-threshold": acs_missing_threshold,} }

    params[:"metadata-monitor"].each do |k, v|
        if not v
            params[:"metadata-monitor"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["metadata-monitor"].each do |k, v|
        if v != params[:"metadata-monitor"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating metadata-monitor') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/metadata-monitor"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting metadata-monitor') do
            client.delete(url)
        end
    end
end