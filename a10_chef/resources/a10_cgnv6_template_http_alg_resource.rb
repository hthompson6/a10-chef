resource_name :a10_cgnv6_template_http_alg

property :a10_name, String, name_property: true
property :header_name_client_ip, String
property :a10_retry, Integer
property :retry_svr_num, Integer
property :request_insert_msisdn, [true, false]
property :radius_sg, String
property :encrypted, String
property :user_tag, String
property :request_insert_client_ip, [true, false]
property :header_name_msisdn, String
property :timeout, Integer
property :include_tunnel_ip, [true, false]
property :secret_string, String
property :a10_method, ['append','replace']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/http-alg/"
    get_url = "/axapi/v3/cgnv6/template/http-alg/%<name>s"
    header_name_client_ip = new_resource.header_name_client_ip
    a10_name = new_resource.a10_name
    retry_svr_num = new_resource.retry_svr_num
    a10_name = new_resource.a10_name
    request_insert_msisdn = new_resource.request_insert_msisdn
    radius_sg = new_resource.radius_sg
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    request_insert_client_ip = new_resource.request_insert_client_ip
    header_name_msisdn = new_resource.header_name_msisdn
    timeout = new_resource.timeout
    include_tunnel_ip = new_resource.include_tunnel_ip
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "http-alg": {"header-name-client-ip": header_name_client_ip,
        "retry": a10_retry,
        "retry-svr-num": retry_svr_num,
        "name": a10_name,
        "request-insert-msisdn": request_insert_msisdn,
        "radius-sg": radius_sg,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "request-insert-client-ip": request_insert_client_ip,
        "header-name-msisdn": header_name_msisdn,
        "timeout": timeout,
        "include-tunnel-ip": include_tunnel_ip,
        "secret-string": secret_string,
        "method": a10_method,
        "uuid": uuid,} }

    params[:"http-alg"].each do |k, v|
        if not v 
            params[:"http-alg"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating http-alg') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/http-alg/%<name>s"
    header_name_client_ip = new_resource.header_name_client_ip
    a10_name = new_resource.a10_name
    retry_svr_num = new_resource.retry_svr_num
    a10_name = new_resource.a10_name
    request_insert_msisdn = new_resource.request_insert_msisdn
    radius_sg = new_resource.radius_sg
    encrypted = new_resource.encrypted
    user_tag = new_resource.user_tag
    request_insert_client_ip = new_resource.request_insert_client_ip
    header_name_msisdn = new_resource.header_name_msisdn
    timeout = new_resource.timeout
    include_tunnel_ip = new_resource.include_tunnel_ip
    secret_string = new_resource.secret_string
    a10_name = new_resource.a10_name
    uuid = new_resource.uuid

    params = { "http-alg": {"header-name-client-ip": header_name_client_ip,
        "retry": a10_retry,
        "retry-svr-num": retry_svr_num,
        "name": a10_name,
        "request-insert-msisdn": request_insert_msisdn,
        "radius-sg": radius_sg,
        "encrypted": encrypted,
        "user-tag": user_tag,
        "request-insert-client-ip": request_insert_client_ip,
        "header-name-msisdn": header_name_msisdn,
        "timeout": timeout,
        "include-tunnel-ip": include_tunnel_ip,
        "secret-string": secret_string,
        "method": a10_method,
        "uuid": uuid,} }

    params[:"http-alg"].each do |k, v|
        if not v
            params[:"http-alg"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["http-alg"].each do |k, v|
        if v != params[:"http-alg"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating http-alg') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/http-alg/%<name>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting http-alg') do
            client.delete(url)
        end
    end
end