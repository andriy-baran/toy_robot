class Medium < OpenStruct
  def method_missing(method_name, *attrs, &block)
    if method_name.match(/\Aon_.*=\z/)
      super
    else
      if respond_to?("on_#{method_name}")
        send(:"on_#{method_name}").call(*attrs, &block)
      else
        super
      end
    end
  end
end
# class Medium
#   def initialize
#     @queries = {}
#   end

#   def method_missing(name, *attrs, &block)
#     if name.match(/\Aon_(.*)/)
#       if @queries.key?(:"#{$1}")
#         yield *@queries.delete(:"#{$1}")
#       end
#     else
#       @queries[name] = attrs
#     end
#   end
# end


