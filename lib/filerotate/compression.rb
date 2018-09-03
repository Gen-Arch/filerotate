require 'zlib'
require 'archive/tar/minitar'

module FileRotate
    module Compression
        def run(path, option)
            option = true if option.nil? 
            if option == true
                gzip(path)
            else
                remove(path)
            end
        end

        def gzip(path)
            current_dir = Dir::pwd
            dir_path = File.join(File.dirname(path),"bak")
            FileUtils.mkdir_p(dir_path) unless FileTest.exist?(dir_path)
            Dir::chdir(File.dirname(dir_path))

            Zlib::GzipWriter.open(File.join(dir_path,"#{File.basename(path)}.tar.gz"), Zlib::BEST_COMPRESSION) do |gz|
                out = Archive::Tar::Minitar::Output.new(gz)
                Archive::Tar::Minitar::pack_file("./#{File.basename(path)}", out)
                out.close
            end
            File.delete(path) #元のファイルを削除させたくない場合はコメントアウト
            Dir::chdir(current_dir)
        end

        def remove(path)
            File.delete(path)
        end

        module_function :run, :gzip, :remove
    end
end