resource_name :a10_accounting_exec

property :a10_name, String, name_property: true
property :accounting_exec_type, ['start-stop','stop-only']
property :accounting_exec_method, ['tacplus','radius']
property :uuid, String

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/accounting/"
    get_url = "/axapi/v3/accounting/exec"
    accounting_exec_type = new_resource.accounting_exec_type
    accounting_exec_method = new_resource.accounting_exec_method
    uuid = new_resource.uuid

    params = { "exec": {"accounting-exec-type": accounting_exec_type,
        "accounting-exec-method": accounting_exec_method,
        "uuid": uuid,} }

    params[:"exec"].each do |k, v|
        if not v 
            params[:"exec"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating exec') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/accounting/exec"
    accounting_exec_type = new_resource.accounting_exec_type
    accounting_exec_method = new_resource.accounting_exec_method
    uuid = new_resource.uuid

    params = { "exec": {"accounting-exec-type": accounting_exec_type,
        "accounting-exec-method": accounting_exec_method,
        "uuid": uuid,} }

    params[:"exec"].each do |k, v|
        if not v
            params[:"exec"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["exec"].each do |k, v|
        if v != params[:"exec"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating exec') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/accounting/exec"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting exec') do
            client.delete(url)
        end
    end
end