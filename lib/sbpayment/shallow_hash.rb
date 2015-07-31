# {
#   :"a" => {
#     :"b" => {
#       :"c" => "d.e.f"
#     }
#   }
# }
# =>
# {
#   "a.b.c" => "d.e.f"
# }
module Sbpayment
  module ShallowHash
    refine Hash do 
      def shallow(parent=nil)
        {}.tap do |hash|
          each do |key, value|
            if value.is_a? Hash
              hash.update value.shallow(parent ? :"#{parent}.#{key}" : key)
            else
              hash[parent ? :"#{parent}.#{key}" : key] = value
            end
          end
        end
      end
    end
  end
end
