require "logger"
require "filerotate/configure"
require "filerotate/checker"
require "filerotate/compression"

module FileRotate
    def start(days)
        config = FileRotate::Configure::get
        
        config["logfile"] = STDOUT if config["logfile"].nil?
        logger = Logger.new(config["logfile"])

        config["dir"].each do |d|
            dir = FileRotate::Checker::update(d,days)
            dir.each do |f|
                logger.info("Compression -> #{f}")
                FileRotate::Compression::run(f,config["compression"])
            end
        end
    end

    module_function :start
end
