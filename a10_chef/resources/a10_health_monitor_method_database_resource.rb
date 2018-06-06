resource_name :a10_health_monitor_method_database

property :a10_name, String, name_property: true
property :db_send, String
property :db_password, [true, false]
property :uuid, String
property :db_encrypted, String
property :database, [true, false]
property :database_name, ['mssql','mysql','oracle','postgresql']
property :db_row_integer, Integer
property :db_receive, String
property :db_receive_integer, Integer
property :db_password_str, String
property :db_column, Integer
property :db_name, String
property :db_column_integer, Integer
property :db_username, String
property :db_row, Integer

property :client, [Class, A10Client::ACOSClient]


action :create do
    client = new_resource.client
    a10_name = new_resource.a10_name
    post_url = "/axapi/v3/health/monitor/%<name>s/method/"
    get_url = "/axapi/v3/health/monitor/%<name>s/method/database"
    db_send = new_resource.db_send
    db_password = new_resource.db_password
    uuid = new_resource.uuid
    db_encrypted = new_resource.db_encrypted
    database = new_resource.database
    database_name = new_resource.database_name
    db_row_integer = new_resource.db_row_integer
    db_receive = new_resource.db_receive
    db_receive_integer = new_resource.db_receive_integer
    db_password_str = new_resource.db_password_str
    db_column = new_resource.db_column
    db_name = new_resource.db_name
    db_column_integer = new_resource.db_column_integer
    db_username = new_resource.db_username
    db_row = new_resource.db_row

    params = { "database": {"db-send": db_send,
        "db-password": db_password,
        "uuid": uuid,
        "db-encrypted": db_encrypted,
        "database": database,
        "database-name": database_name,
        "db-row-integer": db_row_integer,
        "db-receive": db_receive,
        "db-receive-integer": db_receive_integer,
        "db-password-str": db_password_str,
        "db-column": db_column,
        "db-name": db_name,
        "db-column-integer": db_column_integer,
        "db-username": db_username,
        "db-row": db_row,} }

    params[:"database"].each do |k, v|
        if not v 
            params[:"database"].delete(k)
        end
    end

    get_url = get_url % {name: a10_name}

    begin
        client.get(get_url)
    rescue RuntimeError => e
        converge_by('Creating database') do
            client.post(post_url, params: params)
        end
    end
end

action :update do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/database"
    db_send = new_resource.db_send
    db_password = new_resource.db_password
    uuid = new_resource.uuid
    db_encrypted = new_resource.db_encrypted
    database = new_resource.database
    database_name = new_resource.database_name
    db_row_integer = new_resource.db_row_integer
    db_receive = new_resource.db_receive
    db_receive_integer = new_resource.db_receive_integer
    db_password_str = new_resource.db_password_str
    db_column = new_resource.db_column
    db_name = new_resource.db_name
    db_column_integer = new_resource.db_column_integer
    db_username = new_resource.db_username
    db_row = new_resource.db_row

    params = { "database": {"db-send": db_send,
        "db-password": db_password,
        "uuid": uuid,
        "db-encrypted": db_encrypted,
        "database": database,
        "database-name": database_name,
        "db-row-integer": db_row_integer,
        "db-receive": db_receive,
        "db-receive-integer": db_receive_integer,
        "db-password-str": db_password_str,
        "db-column": db_column,
        "db-name": db_name,
        "db-column-integer": db_column_integer,
        "db-username": db_username,
        "db-row": db_row,} }

    params[:"database"].each do |k, v|
        if not v
            params[:"database"].delete(k)
        end
    end

    get_url = url % {name: a10_name}
    result = client.get(get_url)

    found_diff = false 
    result["database"].each do |k, v|
        if v != params[:"database"][k] 
            found_diff = true
        end
    end

    if found_diff
        converge_by('Updating database') do
            client.put(url, params: params)
        end
    end
end

action :delete do
    client = new_resource.client
    a10_name = new_resource.a10_name
    url = "/axapi/v3/health/monitor/%<name>s/method/database"

    url = url % {name: a10_name} 

    result = client.get(url)
    if result
        converge_by('Deleting database') do
            client.delete(url)
        end
    end
end