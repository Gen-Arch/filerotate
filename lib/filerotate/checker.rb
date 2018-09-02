require 'active_support'
require 'active_support/core_ext'

module FileRotate
    module Checker
        def update(dir,days)
            updates = Dir.glob(dir).select{|f| File.mtime(f) < Time.now - days.day }
        end
        module_function :update
    end
end
