require "log_rotation/configure"
require "log_rotation/checker"

module FileRotate
    def start(days)
        config = FileRotate::Configure.get
        config["dir"].each do |f|
            dir = FileRotate::Checker.update(f,days)
            puts dir

        end
        
    end

    module_function :start
end
