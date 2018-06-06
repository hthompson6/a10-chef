resource_name :a10_cgnv6_lsn_lid

property :a10_name, String, name_property: true
property :drop_on_nat_pool_mismatch, [true, false]
property :user_quota_prefix_length, Integer
property :lid_number, Integer,required: true
property :extended_user_quota, Hash
property :ds_lite, Hash
property :user_quota, Hash
property :user_tag, String
property :respond_to_user_mac, [true, false]
property :source_nat_pool, Hash
property :conn_rate_limit, Hash
property :lsn_rule_list, Hash
property :override, ['none','drop','pass-through']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/cgnv6/lsn-lid/"
    get_url = "/axapi/v3/cgnv6/lsn-lid/%<lid-number>s"
    drop_on_nat_pool_mismatch = new_resource.drop_on_nat_pool_mismatch
    user_quota_prefix_length = new_resource.user_quota_prefix_length
    lid_number = new_resource.lid_number
    extended_user_quota = new_resource.extended_user_quota
    ds_lite = new_resource.ds_lite
    user_quota = new_resource.user_quota
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    respond_to_user_mac = new_resource.respond_to_user_mac
    source_nat_pool = new_resource.source_nat_pool
    conn_rate_limit = new_resource.conn_rate_limit
    lsn_rule_list = new_resource.lsn_rule_list
    override = new_resource.override
    uuid = new_resource.uuid

    params = { "lsn-lid": {"drop-on-nat-pool-mismatch": drop_on_nat_pool_mismatch,
        "user-quota-prefix-length": user_quota_prefix_length,
        "lid-number": lid_number,
        "extended-user-quota": extended_user_quota,
        "ds-lite": ds_lite,
        "user-quota": user_quota,
        "user-tag": user_tag,
        "name": a10_name,
        "respond-to-user-mac": respond_to_user_mac,
        "source-nat-pool": source_nat_pool,
        "conn-rate-limit": conn_rate_limit,
        "lsn-rule-list": lsn_rule_list,
        "override": override,
        "uuid": uuid,} }

    params[:"lsn-lid"].each do |k, v|
        if not v 
            params[:"lsn-lid"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lsn-lid') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-lid/%<lid-number>s"
    drop_on_nat_pool_mismatch = new_resource.drop_on_nat_pool_mismatch
    user_quota_prefix_length = new_resource.user_quota_prefix_length
    lid_number = new_resource.lid_number
    extended_user_quota = new_resource.extended_user_quota
    ds_lite = new_resource.ds_lite
    user_quota = new_resource.user_quota
    user_tag = new_resource.user_tag
    a10_name = new_resource.a10_name
    respond_to_user_mac = new_resource.respond_to_user_mac
    source_nat_pool = new_resource.source_nat_pool
    conn_rate_limit = new_resource.conn_rate_limit
    lsn_rule_list = new_resource.lsn_rule_list
    override = new_resource.override
    uuid = new_resource.uuid

    params = { "lsn-lid": {"drop-on-nat-pool-mismatch": drop_on_nat_pool_mismatch,
        "user-quota-prefix-length": user_quota_prefix_length,
        "lid-number": lid_number,
        "extended-user-quota": extended_user_quota,
        "ds-lite": ds_lite,
        "user-quota": user_quota,
        "user-tag": user_tag,
        "name": a10_name,
        "respond-to-user-mac": respond_to_user_mac,
        "source-nat-pool": source_nat_pool,
        "conn-rate-limit": conn_rate_limit,
        "lsn-rule-list": lsn_rule_list,
        "override": override,
        "uuid": uuid,} }

    params[:"lsn-lid"].each do |k, v|
        if not v
            params[:"lsn-lid"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lsn-lid"].each do |k, v|
        if v != params[:"lsn-lid"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lsn-lid') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/cgnv6/lsn-lid/%<lid-number>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lsn-lid') do
            client.delete(url)
        end
    end
end