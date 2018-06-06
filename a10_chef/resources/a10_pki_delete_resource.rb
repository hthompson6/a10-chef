resource_name :a10_pki_delete

property :a10_name, String, name_property: true
property :private_key, String
property :ca, String
property :cert_name, String
property :crl, String
property :csr, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/pki/"
    get_url = "/axapi/v3/pki/delete"
    private_key = new_resource.private_key
    ca = new_resource.ca
    cert_name = new_resource.cert_name
    crl = new_resource.crl
    csr = new_resource.csr

    params = { "delete": {"private-key": private_key,
        "ca": ca,
        "cert-name": cert_name,
        "crl": crl,
        "csr": csr,} }

    params[:"delete"].each do |k, v|
        if not v 
            params[:"delete"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating delete') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/delete"
    private_key = new_resource.private_key
    ca = new_resource.ca
    cert_name = new_resource.cert_name
    crl = new_resource.crl
    csr = new_resource.csr

    params = { "delete": {"private-key": private_key,
        "ca": ca,
        "cert-name": cert_name,
        "crl": crl,
        "csr": csr,} }

    params[:"delete"].each do |k, v|
        if not v
            params[:"delete"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["delete"].each do |k, v|
        if v != params[:"delete"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating delete') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/pki/delete"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting delete') do
            client.delete(url)
        end
    end
end