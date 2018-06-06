resource_name :a10_aam_authentication_saml_service_provider

property :a10_name, String, name_property: true
property :certificate, String
property :require_assertion_signed, Hash
property :artifact_resolution_service, Array
property :service_url, String
property :entity_id, String
property :user_tag, String
property :assertion_consuming_service, Array
property :sampling_enable, Array
property :saml_request_signed, Hash
property :metadata_export_service, Hash
property :adfs_ws_federation, Hash
property :soap_tls_certificate_validate, Hash
property :single_logout_service, Array
property :signature_algorithm, ['SHA1','SHA256']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/aam/authentication/saml/service-provider/"
    get_url = "/axapi/v3/aam/authentication/saml/service-provider/%<name>s"
    a10_name = new_resource.a10_name
    certificate = new_resource.certificate
    require_assertion_signed = new_resource.require_assertion_signed
    artifact_resolution_service = new_resource.artifact_resolution_service
    service_url = new_resource.service_url
    entity_id = new_resource.entity_id
    user_tag = new_resource.user_tag
    assertion_consuming_service = new_resource.assertion_consuming_service
    sampling_enable = new_resource.sampling_enable
    saml_request_signed = new_resource.saml_request_signed
    metadata_export_service = new_resource.metadata_export_service
    adfs_ws_federation = new_resource.adfs_ws_federation
    soap_tls_certificate_validate = new_resource.soap_tls_certificate_validate
    single_logout_service = new_resource.single_logout_service
    signature_algorithm = new_resource.signature_algorithm
    uuid = new_resource.uuid

    params = { "service-provider": {"name": a10_name,
        "certificate": certificate,
        "require-assertion-signed": require_assertion_signed,
        "artifact-resolution-service": artifact_resolution_service,
        "service-url": service_url,
        "entity-id": entity_id,
        "user-tag": user_tag,
        "assertion-consuming-service": assertion_consuming_service,
        "sampling-enable": sampling_enable,
        "saml-request-signed": saml_request_signed,
        "metadata-export-service": metadata_export_service,
        "adfs-ws-federation": adfs_ws_federation,
        "soap-tls-certificate-validate": soap_tls_certificate_validate,
        "single-logout-service": single_logout_service,
        "signature-algorithm": signature_algorithm,
        "uuid": uuid,} }

    params[:"service-provider"].each do |k, v|
        if not v 
            params[:"service-provider"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating service-provider') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/service-provider/%<name>s"
    a10_name = new_resource.a10_name
    certificate = new_resource.certificate
    require_assertion_signed = new_resource.require_assertion_signed
    artifact_resolution_service = new_resource.artifact_resolution_service
    service_url = new_resource.service_url
    entity_id = new_resource.entity_id
    user_tag = new_resource.user_tag
    assertion_consuming_service = new_resource.assertion_consuming_service
    sampling_enable = new_resource.sampling_enable
    saml_request_signed = new_resource.saml_request_signed
    metadata_export_service = new_resource.metadata_export_service
    adfs_ws_federation = new_resource.adfs_ws_federation
    soap_tls_certificate_validate = new_resource.soap_tls_certificate_validate
    single_logout_service = new_resource.single_logout_service
    signature_algorithm = new_resource.signature_algorithm
    uuid = new_resource.uuid

    params = { "service-provider": {"name": a10_name,
        "certificate": certificate,
        "require-assertion-signed": require_assertion_signed,
        "artifact-resolution-service": artifact_resolution_service,
        "service-url": service_url,
        "entity-id": entity_id,
        "user-tag": user_tag,
        "assertion-consuming-service": assertion_consuming_service,
        "sampling-enable": sampling_enable,
        "saml-request-signed": saml_request_signed,
        "metadata-export-service": metadata_export_service,
        "adfs-ws-federation": adfs_ws_federation,
        "soap-tls-certificate-validate": soap_tls_certificate_validate,
        "single-logout-service": single_logout_service,
        "signature-algorithm": signature_algorithm,
        "uuid": uuid,} }

    params[:"service-provider"].each do |k, v|
        if not v
            params[:"service-provider"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["service-provider"].each do |k, v|
        if v != params[:"service-provider"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating service-provider') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/aam/authentication/saml/service-provider/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting service-provider') do
            client.delete(url)
        end
    end
end