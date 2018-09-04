require "logger"
require "filerotate/configure"
require "filerotate/checker"
require "filerotate/compression"

module FileRotate
    def start(days)
        config = FileRotate::Configure::get
        
        config["logfile"] = "#{Dir::pwd}/filerotate.log" if config["logfile"].nil?
        logger = Logger.new(File::expand_path(config["logfile"]))

        config["dir"].each do |d|
            dir = FileRotate::Checker::update(d,days)
            dir.each do |f|
                logger.info("Compression -> #{f}")
                begin
                    FileRotate::Compression::run(f,config["compression"])
                rescue => e
                    logger.warn(e)
                    next
                end
            end
        end
    end

    module_function :start
end
