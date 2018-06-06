resource_name :a10_export

property :a10_name, String, name_property: true
property :geo_location, String
property :ssl_cert_key, String
property :bw_list, String
property :lw_4o6, String
property :tgz, [true, false]
property :merged_pcap, [true, false]
property :syslog, String
property :use_mgmt_port, [true, false]
property :auth_portal, String
property :fixed_nat_archive, String
property :aflex, String
property :fixed_nat, String
property :saml_idp_name, String
property :thales_kmdata, String
property :per_cpu, [true, false]
property :debug_monitor, String
property :policy, String
property :lw_4o6_binding_table_validation_log, String
property :thales_secworld, String
property :csr, String
property :auth_portal_image, String
property :ssl_crl, String
property :class_list, String
property :status_check, [true, false]
property :dnssec_ds, String
property :profile, String
property :local_uri_file, String
property :wsdl, String
property :ssl_key, String
property :store, Hash
property :externalfilename, String
property :remote_file, String
property :store_name, String
property :ca_cert, String
property :axdebug, String
property :running_config, [true, false]
property :xml_schema, String
property :startup_config, [true, false]
property :ssl_cert, String
property :dnssec_dnskey, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/"
    get_url = "/axapi/v3/export"
    geo_location = new_resource.geo_location
    ssl_cert_key = new_resource.ssl_cert_key
    bw_list = new_resource.bw_list
    lw_4o6 = new_resource.lw_4o6
    tgz = new_resource.tgz
    merged_pcap = new_resource.merged_pcap
    syslog = new_resource.syslog
    use_mgmt_port = new_resource.use_mgmt_port
    auth_portal = new_resource.auth_portal
    fixed_nat_archive = new_resource.fixed_nat_archive
    aflex = new_resource.aflex
    fixed_nat = new_resource.fixed_nat
    saml_idp_name = new_resource.saml_idp_name
    thales_kmdata = new_resource.thales_kmdata
    per_cpu = new_resource.per_cpu
    debug_monitor = new_resource.debug_monitor
    policy = new_resource.policy
    lw_4o6_binding_table_validation_log = new_resource.lw_4o6_binding_table_validation_log
    thales_secworld = new_resource.thales_secworld
    csr = new_resource.csr
    auth_portal_image = new_resource.auth_portal_image
    ssl_crl = new_resource.ssl_crl
    class_list = new_resource.class_list
    status_check = new_resource.status_check
    dnssec_ds = new_resource.dnssec_ds
    profile = new_resource.profile
    local_uri_file = new_resource.local_uri_file
    wsdl = new_resource.wsdl
    ssl_key = new_resource.ssl_key
    store = new_resource.store
    externalfilename = new_resource.externalfilename
    remote_file = new_resource.remote_file
    store_name = new_resource.store_name
    ca_cert = new_resource.ca_cert
    axdebug = new_resource.axdebug
    running_config = new_resource.running_config
    xml_schema = new_resource.xml_schema
    startup_config = new_resource.startup_config
    ssl_cert = new_resource.ssl_cert
    dnssec_dnskey = new_resource.dnssec_dnskey

    params = { "export": {"geo-location": geo_location,
        "ssl-cert-key": ssl_cert_key,
        "bw-list": bw_list,
        "lw-4o6": lw_4o6,
        "tgz": tgz,
        "merged-pcap": merged_pcap,
        "syslog": syslog,
        "use-mgmt-port": use_mgmt_port,
        "auth-portal": auth_portal,
        "fixed-nat-archive": fixed_nat_archive,
        "aflex": aflex,
        "fixed-nat": fixed_nat,
        "saml-idp-name": saml_idp_name,
        "thales-kmdata": thales_kmdata,
        "per-cpu": per_cpu,
        "debug-monitor": debug_monitor,
        "policy": policy,
        "lw-4o6-binding-table-validation-log": lw_4o6_binding_table_validation_log,
        "thales-secworld": thales_secworld,
        "csr": csr,
        "auth-portal-image": auth_portal_image,
        "ssl-crl": ssl_crl,
        "class-list": class_list,
        "status-check": status_check,
        "dnssec-ds": dnssec_ds,
        "profile": profile,
        "local-uri-file": local_uri_file,
        "wsdl": wsdl,
        "ssl-key": ssl_key,
        "store": store,
        "externalfilename": externalfilename,
        "remote-file": remote_file,
        "store-name": store_name,
        "ca-cert": ca_cert,
        "axdebug": axdebug,
        "running-config": running_config,
        "xml-schema": xml_schema,
        "startup-config": startup_config,
        "ssl-cert": ssl_cert,
        "dnssec-dnskey": dnssec_dnskey,} }

    params[:"export"].each do |k, v|
        if not v 
            params[:"export"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating export') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/export"
    geo_location = new_resource.geo_location
    ssl_cert_key = new_resource.ssl_cert_key
    bw_list = new_resource.bw_list
    lw_4o6 = new_resource.lw_4o6
    tgz = new_resource.tgz
    merged_pcap = new_resource.merged_pcap
    syslog = new_resource.syslog
    use_mgmt_port = new_resource.use_mgmt_port
    auth_portal = new_resource.auth_portal
    fixed_nat_archive = new_resource.fixed_nat_archive
    aflex = new_resource.aflex
    fixed_nat = new_resource.fixed_nat
    saml_idp_name = new_resource.saml_idp_name
    thales_kmdata = new_resource.thales_kmdata
    per_cpu = new_resource.per_cpu
    debug_monitor = new_resource.debug_monitor
    policy = new_resource.policy
    lw_4o6_binding_table_validation_log = new_resource.lw_4o6_binding_table_validation_log
    thales_secworld = new_resource.thales_secworld
    csr = new_resource.csr
    auth_portal_image = new_resource.auth_portal_image
    ssl_crl = new_resource.ssl_crl
    class_list = new_resource.class_list
    status_check = new_resource.status_check
    dnssec_ds = new_resource.dnssec_ds
    profile = new_resource.profile
    local_uri_file = new_resource.local_uri_file
    wsdl = new_resource.wsdl
    ssl_key = new_resource.ssl_key
    store = new_resource.store
    externalfilename = new_resource.externalfilename
    remote_file = new_resource.remote_file
    store_name = new_resource.store_name
    ca_cert = new_resource.ca_cert
    axdebug = new_resource.axdebug
    running_config = new_resource.running_config
    xml_schema = new_resource.xml_schema
    startup_config = new_resource.startup_config
    ssl_cert = new_resource.ssl_cert
    dnssec_dnskey = new_resource.dnssec_dnskey

    params = { "export": {"geo-location": geo_location,
        "ssl-cert-key": ssl_cert_key,
        "bw-list": bw_list,
        "lw-4o6": lw_4o6,
        "tgz": tgz,
        "merged-pcap": merged_pcap,
        "syslog": syslog,
        "use-mgmt-port": use_mgmt_port,
        "auth-portal": auth_portal,
        "fixed-nat-archive": fixed_nat_archive,
        "aflex": aflex,
        "fixed-nat": fixed_nat,
        "saml-idp-name": saml_idp_name,
        "thales-kmdata": thales_kmdata,
        "per-cpu": per_cpu,
        "debug-monitor": debug_monitor,
        "policy": policy,
        "lw-4o6-binding-table-validation-log": lw_4o6_binding_table_validation_log,
        "thales-secworld": thales_secworld,
        "csr": csr,
        "auth-portal-image": auth_portal_image,
        "ssl-crl": ssl_crl,
        "class-list": class_list,
        "status-check": status_check,
        "dnssec-ds": dnssec_ds,
        "profile": profile,
        "local-uri-file": local_uri_file,
        "wsdl": wsdl,
        "ssl-key": ssl_key,
        "store": store,
        "externalfilename": externalfilename,
        "remote-file": remote_file,
        "store-name": store_name,
        "ca-cert": ca_cert,
        "axdebug": axdebug,
        "running-config": running_config,
        "xml-schema": xml_schema,
        "startup-config": startup_config,
        "ssl-cert": ssl_cert,
        "dnssec-dnskey": dnssec_dnskey,} }

    params[:"export"].each do |k, v|
        if not v
            params[:"export"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["export"].each do |k, v|
        if v != params[:"export"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating export') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/export"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting export') do
            client.delete(url)
        end
    end
end