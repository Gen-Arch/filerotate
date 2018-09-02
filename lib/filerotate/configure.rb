require 'yaml'

module FileRotate
    module Configure
        @default_dir = File.join(File.expand_path('../../', File.dirname(__FILE__)), "conf/config.yml")

        attr_reader :default_dir

        class << self
            def set(dir)
                @default_dir = dir
            end

            def get
                config = YAML.load_file(@default_dir)
            end
        end
    end
end
