require "logger"
require "filerotate/configure"
require "filerotate/checker"
require "filerotate/compression"

module FileRotate
    def start(days)
        config = FileRotate::Configure::get
        logger = Logger.new(config["logfile"])

        config["dir"].each do |d|
            dir = FileRotate::Checker::update(d,days)
            dir.each do |f|
                logger.info("Compression -> #{f}")
                if config["compression"] == false
                    FileRotate::Compression::remove(f)
                else
                    FileRotate::Compression::gzip(f)
                end
            end
        end
    end
    module_function :start
end
