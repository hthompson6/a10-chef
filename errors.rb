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

class AcosException < StandarError
    attr_reader :code
    attr_reader :msg

    def initialize(code=1, msg='')
        @code = code
        @msg = msg
        super(msg)
    end

    def to_s
        return "#{code} #{msg}"
    end

    def to_str
        return to_s
    end
end


class ACOSUnsupportedVersion < ACOSException; end


class ACOSUnknownError < ACOSException; end


class AddressSpecifiedIsInUse < ACOSException; end


class AuthenticationFailure < ACOSException; end


class InvalidSessionID < ACOSException; end


class Exists < ACOSException; end


class NotFound < ACOSException; end


class NoSuchServiceGroup < ACOSException; end


class NotImplemented < ACOSException; end


class InUse < ACOSException; end 


class InvalidPartitionParameter < ACOSException; end


class MemoryFault < ACOSException; end


class InvalidParameter < ACOSException; end


class OutOfPartitions < ACOSException; end


class PartitionIdExists < ACOSException; end


class HMMissingHttpPassive < ACOSException; end


class AxapiJsonFormatError < ACOSException; end


class ConfigManagerNotReady < ACOSException; end
