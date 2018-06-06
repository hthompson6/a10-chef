resource_name :a10_cgnv6_template_dns_dns64

property :a10_name, String, name_property: true
property :deep_check_rr_disable, [true, false]
property :answer_only_disable, [true, false]
property :enable, [true, false]
property :single_response_disable, [true, false]
property :uuid, String
property :max_qr_length, Integer
property :ignore_rcode3_disable, [true, false]
property :auth_data, [true, false]
property :change_query, [true, false]
property :drop_cname_disable, [true, false]
property :cache, [true, false]
property :passive_query_disable, [true, false]
property :a10_retry, Integer
property :parallel_query, [true, false]
property :timeout, Integer
property :ttl, Integer
property :trans_ptr_query, [true, false]
property :trans_ptr, [true, false]
property :compress_disable, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/template/dns/%<name>s/"
    get_url = "/axapi/v3/cgnv6/template/dns/%<name>s/dns64"
    deep_check_rr_disable = new_resource.deep_check_rr_disable
    answer_only_disable = new_resource.answer_only_disable
    enable = new_resource.enable
    single_response_disable = new_resource.single_response_disable
    uuid = new_resource.uuid
    max_qr_length = new_resource.max_qr_length
    ignore_rcode3_disable = new_resource.ignore_rcode3_disable
    auth_data = new_resource.auth_data
    change_query = new_resource.change_query
    drop_cname_disable = new_resource.drop_cname_disable
    cache = new_resource.cache
    passive_query_disable = new_resource.passive_query_disable
    a10_name = new_resource.a10_name
    parallel_query = new_resource.parallel_query
    timeout = new_resource.timeout
    ttl = new_resource.ttl
    trans_ptr_query = new_resource.trans_ptr_query
    trans_ptr = new_resource.trans_ptr
    compress_disable = new_resource.compress_disable

    params = { "dns64": {"deep-check-rr-disable": deep_check_rr_disable,
        "answer-only-disable": answer_only_disable,
        "enable": enable,
        "single-response-disable": single_response_disable,
        "uuid": uuid,
        "max-qr-length": max_qr_length,
        "ignore-rcode3-disable": ignore_rcode3_disable,
        "auth-data": auth_data,
        "change-query": change_query,
        "drop-cname-disable": drop_cname_disable,
        "cache": cache,
        "passive-query-disable": passive_query_disable,
        "retry": a10_retry,
        "parallel-query": parallel_query,
        "timeout": timeout,
        "ttl": ttl,
        "trans-ptr-query": trans_ptr_query,
        "trans-ptr": trans_ptr,
        "compress-disable": compress_disable,} }

    params[:"dns64"].each do |k, v|
        if not v 
            params[:"dns64"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating dns64') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s/dns64"
    deep_check_rr_disable = new_resource.deep_check_rr_disable
    answer_only_disable = new_resource.answer_only_disable
    enable = new_resource.enable
    single_response_disable = new_resource.single_response_disable
    uuid = new_resource.uuid
    max_qr_length = new_resource.max_qr_length
    ignore_rcode3_disable = new_resource.ignore_rcode3_disable
    auth_data = new_resource.auth_data
    change_query = new_resource.change_query
    drop_cname_disable = new_resource.drop_cname_disable
    cache = new_resource.cache
    passive_query_disable = new_resource.passive_query_disable
    a10_name = new_resource.a10_name
    parallel_query = new_resource.parallel_query
    timeout = new_resource.timeout
    ttl = new_resource.ttl
    trans_ptr_query = new_resource.trans_ptr_query
    trans_ptr = new_resource.trans_ptr
    compress_disable = new_resource.compress_disable

    params = { "dns64": {"deep-check-rr-disable": deep_check_rr_disable,
        "answer-only-disable": answer_only_disable,
        "enable": enable,
        "single-response-disable": single_response_disable,
        "uuid": uuid,
        "max-qr-length": max_qr_length,
        "ignore-rcode3-disable": ignore_rcode3_disable,
        "auth-data": auth_data,
        "change-query": change_query,
        "drop-cname-disable": drop_cname_disable,
        "cache": cache,
        "passive-query-disable": passive_query_disable,
        "retry": a10_retry,
        "parallel-query": parallel_query,
        "timeout": timeout,
        "ttl": ttl,
        "trans-ptr-query": trans_ptr_query,
        "trans-ptr": trans_ptr,
        "compress-disable": compress_disable,} }

    params[:"dns64"].each do |k, v|
        if not v
            params[:"dns64"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["dns64"].each do |k, v|
        if v != params[:"dns64"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating dns64') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/template/dns/%<name>s/dns64"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting dns64') do
            client.delete(url)
        end
    end
end