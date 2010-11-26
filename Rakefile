module VIM
  Dirs = %w[ after autoload doc plugin ruby snippets syntax ftdetect ftplugin colors indent ]
end

directory "tmp"
VIM::Dirs.each do |dir|
  directory(dir)
end

def vim_plugin_task(name, repo=nil)
  cwd = File.expand_path("../", __FILE__)
  dir = File.expand_path("tmp/#{name}")
  subdirs = VIM::Dirs

  namespace(name) do
    if repo
      file dir => "tmp" do
        if repo =~ /git$/
          sh "git clone #{repo} #{dir}"

        elsif repo =~ /download_script/
          if filename = `curl --silent --head #{repo} | grep attachment`[/filename=(.+)/,1]
            filename.strip!
            sh "curl #{repo} > tmp/#{filename}"
          else
            raise ArgumentError, 'unable to determine script type'
          end

        elsif repo =~ /(tar|gz|vba|zip)$/
          filename = File.basename(repo)
          sh "curl #{repo} > tmp/#{filename}"

        else
          raise ArgumentError, 'unrecognized source url for plugin'
        end

        case filename
        when /zip$/
          sh "unzip -o tmp/#{filename} -d #{dir}"

        when /tar\.gz$/
          dirname  = File.basename(filename, '.tar.gz')

          sh "tar zxvf tmp/#{filename}"
          sh "mv #{dirname} #{dir}"

        when /vba(\.gz)?$/
          if filename =~ /gz$/
            sh "gunzip -f tmp/#{filename}"
            filename = File.basename(filename, '.gz')
          end

          # TODO: move this into the install task
          mkdir_p dir
          lines = File.readlines("tmp/#{filename}")
          current = lines.shift until current =~ /finish$/ # find finish line

          while current = lines.shift
            # first line is the filename, followed by some unknown data
            file = current[/^(.+?)\s+\[\[\[(\d+)$/, 1]

            # then the size of the payload in lines
            current = lines.shift
            num_lines = current[/^(\d+)$/, 1].to_i

            # the data itself
            data = lines.slice!(0, num_lines).join

            # install the data
            Dir.chdir dir do
              mkdir_p File.dirname(file)
              File.open(file, 'w'){ |f| f.write(data) }
            end
          end
        end
      end

      task :pull => dir do
        if repo =~ /git$/
          Dir.chdir dir do
            sh "git pull"
          end
        end
      end

      task :install => [:pull] + subdirs do
        Dir.chdir dir do
          if File.exists?("Rakefile") and `rake -T` =~ /^rake install/
            sh "rake install"
          elsif File.exists?("install.sh")
            sh "sh install.sh"
          else
            subdirs.each do |subdir|
              if File.exists?(subdir)
                sh "cp -rf #{subdir}/* #{cwd}/#{subdir}/"
              end
            end
          end
        end

        yield if block_given?
      end
    else
      task :install => subdirs do
        yield if block_given?
      end
    end
  end

  desc "Install #{name} plugin"
  task name do
    puts
    puts "*" * 40
    puts "*#{"Installing #{name}".center(38)}*"
    puts "*" * 40
    puts
    Rake::Task["#{name}:install"].invoke
  end
  task :default => name
end

vim_plugin_task "ack.vim",          "git://github.com/mileszs/ack.vim.git"
vim_plugin_task "conque",           "http://conque.googlecode.com/files/conque_1.1.tar.gz"
vim_plugin_task "fugitive",         "git://github.com/tpope/vim-fugitive.git"
vim_plugin_task "git",              "git://github.com/tpope/vim-git.git"
vim_plugin_task "haml",             "git://github.com/tpope/vim-haml.git"
vim_plugin_task "indent_object",    "git://github.com/michaeljsmith/vim-indent-object.git"
vim_plugin_task "javascript",       "git://github.com/pangloss/vim-javascript.git"
vim_plugin_task "markdown_preview", "git://github.com/robgleeson/vim-markdown-preview.git"
vim_plugin_task "nerdtree",         "git://github.com/scrooloose/nerdtree.git"
vim_plugin_task "nerdcommenter",    "git://github.com/scrooloose/nerdcommenter.git"
vim_plugin_task "surround",         "git://github.com/tpope/vim-surround.git"
vim_plugin_task "taglist",          "git://github.com/vim-scripts/taglist.vim.git"
vim_plugin_task "vividchalk",       "git://github.com/tpope/vim-vividchalk.git"
vim_plugin_task "supertab",         "git://github.com/ervandew/supertab.git"
vim_plugin_task "cucumber",         "git://github.com/tpope/vim-cucumber.git"
vim_plugin_task "textile",          "git://github.com/timcharper/textile.vim.git"
vim_plugin_task "rails",            "git://github.com/tpope/vim-rails.git"
vim_plugin_task "rspec",            "git://github.com/taq/vim-rspec.git"
vim_plugin_task "zoomwin",          "git://github.com/vim-scripts/ZoomWin.git"
vim_plugin_task "snipmate",         "git://github.com/msanders/snipmate.vim.git"
vim_plugin_task "markdown",         "git://github.com/tpope/vim-markdown.git"
vim_plugin_task "unimpaired",       "git://github.com/tpope/vim-unimpaired.git"
vim_plugin_task "rvm",              "git://github.com/csexton/rvm.vim.git"
vim_plugin_task "gist",             "git://github.com/mattn/gist-vim.git"
vim_plugin_task "vimwiki",          "git://github.com/vim-scripts/vimwiki.git"
vim_plugin_task "tabular",          "git://github.com/godlygeek/tabular.git"
vim_plugin_task "bufexplorer",      "git://github.com/vim-scripts/bufexplorer.zip.git"

vim_plugin_task "ir_black-theme" do
  sh "curl http://blog.infinitered.com/entry_files/8/ir_black.vim > colors/ir_black.vim"
end

vim_plugin_task "snipmate.vim",     "http://github.com/msanders/snipmate.vim.git" do
  cwd = File.expand_path("../", __FILE__)
  other_dirs = %w[ after snippets ]
  other_dirs.each { |d| mkdir_p d }

  Dir.chdir "tmp/snipmate.vim" do
    other_dirs.each do |subdir|
      if File.exists?(subdir)
        sh "cp -rf #{subdir}/* #{cwd}/#{subdir}/"
      end
    end
  end
end

vim_plugin_task "command_t",        "git://github.com/wincent/Command-T.git" do
  sh "find ruby -name '.gitignore' | xargs rm"
  Dir.chdir "ruby/command-t" do
    if `rvm > /dev/null 2>&1` && $?.exitstatus == 1
      sh "rvm system ruby extconf.rb"
    else
      sh "/usr/bin/ruby extconf.rb" # assume /usr/bin/ruby is system ruby
    end
    sh "make clean && make"
  end
end

desc "Cleanup all the files"
task :clean do
  rm_rf "tmp"
end

desc "Update the documentation"
task :update_docs do
  puts "Updating VIM Documentation..."
  system "vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF"
end

desc "link vimrc to ~/.vimrc"
task :link_vimrc do
  %w[ vimrc gvimrc vimrc.local ].each do |file|
    dest = File.expand_path("~/.#{file}")
    unless File.exist?(dest)
      ln_s(File.expand_path("../#{file}", __FILE__), dest)
    end
  end
end

task :default => [
  :update_docs,
  :link_vimrc
]
