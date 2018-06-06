resource_name :a10_vpn_revocation

property :a10_name, String, name_property: true
property :ca, String
property :user_tag, String
property :ocsp, Hash
property :crl, Hash
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/vpn/revocation/"
    get_url = "/axapi/v3/vpn/revocation/%<name>s"
    a10_name = new_resource.a10_name
    ca = new_resource.ca
    user_tag = new_resource.user_tag
    ocsp = new_resource.ocsp
    crl = new_resource.crl
    uuid = new_resource.uuid

    params = { "revocation": {"name": a10_name,
        "ca": ca,
        "user-tag": user_tag,
        "ocsp": ocsp,
        "crl": crl,
        "uuid": uuid,} }

    params[:"revocation"].each do |k, v|
        if not v 
            params[:"revocation"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating revocation') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/revocation/%<name>s"
    a10_name = new_resource.a10_name
    ca = new_resource.ca
    user_tag = new_resource.user_tag
    ocsp = new_resource.ocsp
    crl = new_resource.crl
    uuid = new_resource.uuid

    params = { "revocation": {"name": a10_name,
        "ca": ca,
        "user-tag": user_tag,
        "ocsp": ocsp,
        "crl": crl,
        "uuid": uuid,} }

    params[:"revocation"].each do |k, v|
        if not v
            params[:"revocation"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["revocation"].each do |k, v|
        if v != params[:"revocation"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating revocation') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/vpn/revocation/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting revocation') do
            client.delete(url)
        end
    end
end