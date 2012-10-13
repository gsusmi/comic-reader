module Sync
  class TextEncoding
    def self.encode(text)
      (text || '').encode('UTF-8', undef: :replace, replace: '')
    end
  end
end
