resource_name :a10_interface_lif

property :a10_name, String, name_property: true
property :isis, Hash
property :uuid, String
property :bfd, Hash
property :ip, Hash
property :ifnum, Integer,required: true
property :user_tag, String
property :mtu, Integer
property :a10_action, ['enable','disable']
property :sampling_enable, Array
property :access_list, Hash

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/interface/lif/"
    get_url = "/axapi/v3/interface/lif/%<ifnum>s"
    isis = new_resource.isis
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    ip = new_resource.ip
    ifnum = new_resource.ifnum
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    access_list = new_resource.access_list

    params = { "lif": {"isis": isis,
        "uuid": uuid,
        "bfd": bfd,
        "ip": ip,
        "ifnum": ifnum,
        "user-tag": user_tag,
        "mtu": mtu,
        "action": a10_action,
        "sampling-enable": sampling_enable,
        "access-list": access_list,} }

    params[:"lif"].each do |k, v|
        if not v 
            params[:"lif"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating lif') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s"
    isis = new_resource.isis
    uuid = new_resource.uuid
    bfd = new_resource.bfd
    ip = new_resource.ip
    ifnum = new_resource.ifnum
    user_tag = new_resource.user_tag
    mtu = new_resource.mtu
    a10_name = new_resource.a10_name
    sampling_enable = new_resource.sampling_enable
    access_list = new_resource.access_list

    params = { "lif": {"isis": isis,
        "uuid": uuid,
        "bfd": bfd,
        "ip": ip,
        "ifnum": ifnum,
        "user-tag": user_tag,
        "mtu": mtu,
        "action": a10_action,
        "sampling-enable": sampling_enable,
        "access-list": access_list,} }

    params[:"lif"].each do |k, v|
        if not v
            params[:"lif"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["lif"].each do |k, v|
        if v != params[:"lif"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating lif') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/interface/lif/%<ifnum>s"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting lif') do
            client.delete(url)
        end
    end
end