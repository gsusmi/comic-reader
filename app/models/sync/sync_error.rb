module Sync
  class SyncError < StandardError
    attr_reader :cause

    def initialize(cause)
      @cause = cause
    end
  end
end
