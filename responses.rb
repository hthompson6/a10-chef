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

require_relative 'errors'


module ErrorResp

    @@RESPONSE_CODES = {
        33619969: {
            '*': {
                '*': AE::InUse
            }
        },
        67371011: {
            '*': {
                '*': AE::Exists
             }
        },
        419495936: {
            '*': {
                '/axapi/v3/logoff': nil,
                '*': AE::InvalidSessionID
            }
        },
        520749062: {
            '*': {
                '*': AE::NotFound
            }
        },
        654311495: {
            '*': {
                '*': AE::Exists
            }
        },
        67240011: {
            '*': {
                '*': AE::Exists
            }
        },
        754974732: {
            '*': {
                '*': AE::Exists
            }
        },
        754974733: {
            '*': {
                '*': AE::PartitionIdExists
            }
        },
        1023410176: {
            'DELETE': {
                '*': nil
            },
            '*': {
                '*': AE::NotFound
            }
        },
        1023410181: {
            'DELETE': {
                '*': nil
            },
            '*': {
                '/axapi/v3/slb/service-group/.*/member/': AE::NotFound,
                '*': AE::NotFound
            }
        },
        1023410183: {
            '*': {
                '*': AE::Exists
            }
        },
        1023451145: {
            '*': {
                '*': AE::Exists
            }
        },
        1023459339: {
            '*': {
                '/axapi/v3/slb/server': AE::Exists
            }
        },
        1023459393: {
            '*': {
                '*': AE::InvalidParameter
            }
        },
        1023459335: {
            '*': {
                '*': AE::Exists
            }
        },
        1023460352: {
            'DELETE': {
                '*': None
            },
            '*': {
                '*': AE::NotFound
            }
        },
        1023463424: {
            '*': {
                '*': AE::ConfigManagerNotReady
            }
        },
        1023475722: {
            '*': {
                '*': AE::NotFound
            }
        },
        1023508480: {
            '*': {
                '*': AE::AxapiJsonFormatError
            }
        },
        1023509504: {
            '*': {
                '*': AE::NotFound
            }
        },
        1023524874: {
            '*': {
                '*': AE::AxapiJsonFormatError
            }
        },
        1023656960: {
            '*': {
                '*': AE::NotFound
            }
        },
        1023656962: {
            '*': {
                '*': AE::NotFound
            }
        },
        1207960052: {
            '*': {
                '/axapi/v3/logoff': None,
                '*': AE::InvalidSessionID
            }
        },
        1207959957: {
            '*': {
                '*': AE::NotFound
            }
        },
        1208025092: {
            '*': {
                '/axapi/v3/logoff': None,
                '*': AE::InvalidSessionID
            }
        },
        1208025095: {
            '*': {
                '*': AE::ConfigManagerNotReady
            }
        },
        1023443968: {
            'DELETE': {
                '*': None
            },
            '*': {
                '*': AE::NotFound
            }
        },
        1023451144: {
            '*': {
                '*': AE::Exists
            }
        },
        1023475727: {
            '*': {
                '*': AE::NotFound
            }
        },
        4294967295: {
            '*': {
                '*': AE::ConfigManagerNotReady
            }
        },
    }

    def self.raise_axapi_error(response, method, api_url, headers)
        if response['authorizationschema']
            code = response['authorizationschema']['code']
            s = response['authorzationschema']['error']
            if code == 401
                if headers and 'Authorization' in headers
                    raise AE::InvalideSessionID.new(code, s)
                else
                    raise AE::AuthenticationFailure.new(code, s)
                end
            elsif code == 403
                raise AE::Authenticationfailure.new(code, s)
            end
        end
    end

    def self.raise_axapi_ex(response, method, api_url)
        if response['response']['err']['code']
            if @@RESPONSE_CODES[code]
                ex_dict = @@RESPONSE_CODES[code]
                ex = nil

                if ex_dict[method]
                    x = ex_dict[method]
                else
                    x = ex_dict['*']
                end

                matched = false
                x.each do |k, v|
                    if k != '*' && api_url =~ /^#{k}/
                        matched = true
                        ex = x['*']
                    end
                end

                if !matched && !ex && x['*'] != nil
                    ex = x['*']
                end

                if ex
                    raise ex.new(code, resposne['response']['err']['msg'])
                else
                    return
                end
            end

            raise ACOSException.new(code, response['response']['err']['msg'])
        end
    end
 
    raise ACOSException.new()
end
