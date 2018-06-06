resource_name :a10_debug_sip

property :a10_name, String, name_property: true
property :INFO, [true, false]
property :uuid, String
property :REFER, [true, false]
property :ACK, [true, false]
property :REGISTER, [true, false]
property :PRACK, [true, false]
property :UPDATE, [true, false]
property :PUBLISH, [true, false]
property :a10_method, [true, false]
property :SUBSCRIBE, [true, false]
property :NOTIFY, [true, false]
property :CANCEL, [true, false]
property :MESSAGE, [true, false]
property :BYE, [true, false]
property :OPTIONS, [true, false]
property :INVITE, [true, false]

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/debug/"
    get_url = "/axapi/v3/debug/sip"
    INFO = new_resource.INFO
    uuid = new_resource.uuid
    REFER = new_resource.REFER
    ACK = new_resource.ACK
    REGISTER = new_resource.REGISTER
    PRACK = new_resource.PRACK
    UPDATE = new_resource.UPDATE
    PUBLISH = new_resource.PUBLISH
    a10_name = new_resource.a10_name
    SUBSCRIBE = new_resource.SUBSCRIBE
    NOTIFY = new_resource.NOTIFY
    CANCEL = new_resource.CANCEL
    MESSAGE = new_resource.MESSAGE
    BYE = new_resource.BYE
    OPTIONS = new_resource.OPTIONS
    INVITE = new_resource.INVITE

    params = { "sip": {"INFO": INFO,
        "uuid": uuid,
        "REFER": REFER,
        "ACK": ACK,
        "REGISTER": REGISTER,
        "PRACK": PRACK,
        "UPDATE": UPDATE,
        "PUBLISH": PUBLISH,
        "method": a10_method,
        "SUBSCRIBE": SUBSCRIBE,
        "NOTIFY": NOTIFY,
        "CANCEL": CANCEL,
        "MESSAGE": MESSAGE,
        "BYE": BYE,
        "OPTIONS": OPTIONS,
        "INVITE": INVITE,} }

    params[:"sip"].each do |k, v|
        if not v 
            params[:"sip"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating sip') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/sip"
    INFO = new_resource.INFO
    uuid = new_resource.uuid
    REFER = new_resource.REFER
    ACK = new_resource.ACK
    REGISTER = new_resource.REGISTER
    PRACK = new_resource.PRACK
    UPDATE = new_resource.UPDATE
    PUBLISH = new_resource.PUBLISH
    a10_name = new_resource.a10_name
    SUBSCRIBE = new_resource.SUBSCRIBE
    NOTIFY = new_resource.NOTIFY
    CANCEL = new_resource.CANCEL
    MESSAGE = new_resource.MESSAGE
    BYE = new_resource.BYE
    OPTIONS = new_resource.OPTIONS
    INVITE = new_resource.INVITE

    params = { "sip": {"INFO": INFO,
        "uuid": uuid,
        "REFER": REFER,
        "ACK": ACK,
        "REGISTER": REGISTER,
        "PRACK": PRACK,
        "UPDATE": UPDATE,
        "PUBLISH": PUBLISH,
        "method": a10_method,
        "SUBSCRIBE": SUBSCRIBE,
        "NOTIFY": NOTIFY,
        "CANCEL": CANCEL,
        "MESSAGE": MESSAGE,
        "BYE": BYE,
        "OPTIONS": OPTIONS,
        "INVITE": INVITE,} }

    params[:"sip"].each do |k, v|
        if not v
            params[:"sip"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["sip"].each do |k, v|
        if v != params[:"sip"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating sip') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/debug/sip"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting sip') do
            client.delete(url)
        end
    end
end