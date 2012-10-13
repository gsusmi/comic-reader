module Sync
  class TextEncoding
    def encode(text)
      (text || '').encode('UTF-8', undef: :replace, replace: '')
    end
  end
end
