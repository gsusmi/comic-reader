# from: https://gist.github.com/308975

module Jobs
  module ScheduledJob
    def self.included(base)
      base.extend(ClassMethods)
    end

    def perform_with_schedule
      Delayed::Job.destroy_all
      Delayed::Job.enqueue self, 0, self.class.schedule.from_now.getutc, queue: 'feedsync'
      perform_without_schedule
    end

    module ClassMethods
      def method_added(name)
        if name.to_s == "perform" && !@redefined
          @redefined = true
          alias_method_chain :perform, :schedule
        end
      end

      def schedule
        @schedule
      end

      def run_every(time)
        @schedule = time
      end
    end

  end
end
