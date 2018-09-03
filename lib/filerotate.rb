require "filerotate/configure"
require "filerotate/checker"
require "filerotate/compression"

module FileRotate
    def start(days)
        config = FileRotate::Configure.get
        config["dir"].each do |d|
            dir = FileRotate::Checker.update(d,days)
            puts dir
            
            dir.each do |f|
                puts "Compression -> #{f}"
                FileRotate::Compression::gzip(f)
                puts
            end
        end
    end
    module_function :start
end
