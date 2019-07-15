module TheToy
  class Medium < OpenStruct
    def method_missing(method_name, *attrs, &block)
      if method_name.match(/\A[on|when]_.*=\z/)
        super
      else
        if respond_to?("on_#{method_name}")
          send(:"on_#{method_name}").call(*attrs, &block)
        elsif respond_to?("when_#{method_name}")
          send(:"when_#{method_name}").call(*attrs, &block)
        else
          super
        end
      end
    end
  end
end



