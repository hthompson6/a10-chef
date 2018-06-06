resource_name :a10_dnssec_template

property :a10_name, String, name_property: true
property :uuid, String
property :algorithm, ['RSASHA1','RSASHA256','RSASHA512']
property :combinations_limit, Integer
property :dnskey_ttl_k, [true, false]
property :user_tag, String
property :hsm, String
property :enable_nsec3, [true, false]
property :return_nsec_on_failure, [true, false]
property :dnskey_ttl_v, Integer
property :signature_validity_period_k, [true, false]
property :dnssec_template_ksk, Hash
property :dnssec_template_zsk, Hash
property :signature_validity_period_v, Integer
property :dnssec_temp_name, String,required: true

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/dnssec/template/"
    get_url = "/axapi/v3/dnssec/template/%<dnssec-temp-name>s"
    uuid = new_resource.uuid
    algorithm = new_resource.algorithm
    combinations_limit = new_resource.combinations_limit
    dnskey_ttl_k = new_resource.dnskey_ttl_k
    user_tag = new_resource.user_tag
    hsm = new_resource.hsm
    enable_nsec3 = new_resource.enable_nsec3
    return_nsec_on_failure = new_resource.return_nsec_on_failure
    dnskey_ttl_v = new_resource.dnskey_ttl_v
    signature_validity_period_k = new_resource.signature_validity_period_k
    dnssec_template_ksk = new_resource.dnssec_template_ksk
    dnssec_template_zsk = new_resource.dnssec_template_zsk
    signature_validity_period_v = new_resource.signature_validity_period_v
    dnssec_temp_name = new_resource.dnssec_temp_name

    params = { "template": {"uuid": uuid,
        "algorithm": algorithm,
        "combinations-limit": combinations_limit,
        "dnskey-ttl-k": dnskey_ttl_k,
        "user-tag": user_tag,
        "hsm": hsm,
        "enable-nsec3": enable_nsec3,
        "return-nsec-on-failure": return_nsec_on_failure,
        "dnskey-ttl-v": dnskey_ttl_v,
        "signature-validity-period-k": signature_validity_period_k,
        "dnssec-template-ksk": dnssec_template_ksk,
        "dnssec-template-zsk": dnssec_template_zsk,
        "signature-validity-period-v": signature_validity_period_v,
        "dnssec-temp-name": dnssec_temp_name,} }

    params[:"template"].each do |k, v|
        if not v 
            params[:"template"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating template') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/template/%<dnssec-temp-name>s"
    uuid = new_resource.uuid
    algorithm = new_resource.algorithm
    combinations_limit = new_resource.combinations_limit
    dnskey_ttl_k = new_resource.dnskey_ttl_k
    user_tag = new_resource.user_tag
    hsm = new_resource.hsm
    enable_nsec3 = new_resource.enable_nsec3
    return_nsec_on_failure = new_resource.return_nsec_on_failure
    dnskey_ttl_v = new_resource.dnskey_ttl_v
    signature_validity_period_k = new_resource.signature_validity_period_k
    dnssec_template_ksk = new_resource.dnssec_template_ksk
    dnssec_template_zsk = new_resource.dnssec_template_zsk
    signature_validity_period_v = new_resource.signature_validity_period_v
    dnssec_temp_name = new_resource.dnssec_temp_name

    params = { "template": {"uuid": uuid,
        "algorithm": algorithm,
        "combinations-limit": combinations_limit,
        "dnskey-ttl-k": dnskey_ttl_k,
        "user-tag": user_tag,
        "hsm": hsm,
        "enable-nsec3": enable_nsec3,
        "return-nsec-on-failure": return_nsec_on_failure,
        "dnskey-ttl-v": dnskey_ttl_v,
        "signature-validity-period-k": signature_validity_period_k,
        "dnssec-template-ksk": dnssec_template_ksk,
        "dnssec-template-zsk": dnssec_template_zsk,
        "signature-validity-period-v": signature_validity_period_v,
        "dnssec-temp-name": dnssec_temp_name,} }

    params[:"template"].each do |k, v|
        if not v
            params[:"template"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["template"].each do |k, v|
        if v != params[:"template"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating template') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/dnssec/template/%<dnssec-temp-name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting template') do
            client.delete(url)
        end
    end
end