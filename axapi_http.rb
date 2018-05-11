# Copyright 2018,  A10 Networks.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

require 'net/http'

class HttpClient
    @@HEADERS = {
        "Content-type" => "application/json",
        "User-Agent" => "a10-chef"
    }

    def initialize(host, protocol="https", port=nil, timeout=nil,
                   retry_errno_list=nil)
        @host = host
        @timeout = timeout
        if port == nil
            if protocol == "https"
                @port = 443
            else
                @port = 80
            end
        end
        @url_base = "#{protocol}://#{@host}:#{@port}"
        print "\n#{@url_base}\n"
        @rety_errno_list = retry_errno_list
    end

    def request(method, api_url, params={}, headers=nil, filename=nil,
                file_content=nil, axapi_args=nil, **kwargs)
        if axapi_args != nil
            formatted_axapi_args = (axapi_args.map.each {|pair| pair.map{|x| x.gsub("-", "_")}}).to_h
        end
end

client = HttpClient.new("1.1.1.1")
