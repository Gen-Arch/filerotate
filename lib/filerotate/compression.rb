require 'zlib'
require 'archive/tar/minitar'

module FileRotate
    module Compression
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
        module_function :gzip
    end
end