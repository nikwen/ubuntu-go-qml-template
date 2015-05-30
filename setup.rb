#!/usr/bin/env ruby
# This script will adopt the ubuntu-go-qml-template to 
# it will 

require 'optparse'
require 'ostruct'
require 'pp'


class TemplateSetup

  def initialize(argv)
    op = option_parser 
    op.parse!(argv)
    check_options
  end

  def run
    process
  end

  private

  def process
    print_steps
    puts "working with name '#{@options.name}'"
    # beware! - ordering matters!
    gsub_files
    rename_dirs
    rename_files
    finish
  end

  def option_parser
    @options = OpenStruct.new

    op = OptionParser.new do |opts|
      opts.banner = "Usage: setup.rb [options]"
     
      opts.on("-v", "--verbose", "Be somhow verbose...") do |v|
        @options.verbose = true
      end
      opts.on("-n APPNAME", "--name APPNAME", "The mandatory name of your app" ) do |n|
        @options.name = n
      end
      opts.on("-e EMAIL", "--email EMAIL", "mandatory maintainer's email - probably yours...") do |m|
        @options.email = m
      end
      opts.on("-a AUTHOR", "--author AUTHOR", "mandatory maintainer's name - guess its yours also..") do |a|
        @options.author = a
      end

      opts.on_tail("-h", "--help", "Show this message") do
        @options.verbose = true
        @options.name = "[APPNAME]"
        puts opts
        puts "######################\n"
        print_steps
        exit
      end
    end
    @options.op = op
    op
  end

  def check_options
    if @options.name.nil? || @options.email.nil? || @options.author.nil?
      puts @options.op
      exit 1
    end
  end

  def print_steps
    return unless @options.verbose
    puts "Steps about to be done:\n "
    puts " -> adopt run.sh"
    puts " -> adopt build.sh"
    puts " -> adopt build-in-chroot.sh"
    puts " -> adopt ubuntu-go-qml-template.desktop"
    puts " -> adopt ubuntu-go-qml-template.goproject"
    puts " -> adopt src/ubuntu-go-qml-template/main.go"
    puts " -> adopt share/ubuntu-go-qml-template/main.qml"
    puts " -> adopt ubuntu-go-qml-template.desktop"
    puts " -> rename dir shared/ubuntu-go-qml-template to shared/#{@options.name}"
    puts " -> rename dir src/ubuntu-go-qml-template to src/#{@options.name}"
    puts " -> rename file ubuntu-go-qml-template.apparmor to #{@options.name}.apparmor"
    puts " -> rename file ubuntu-go-qml-template.desktop to #{@options.name}.desktop"
    puts " -> rename file ubuntu-go-qml-template.goproject to #{@options.name}.goproject"
    puts " -> rename file ubuntu-go-qml-template.png to #{@options.name}.png"
  end

  def gsub_files
    file_names =  [
                  'ubuntu-go-qml-template.desktop',
                  'ubuntu-go-qml-template.goproject',
                  'src/ubuntu-go-qml-template/main.go',
                  'share/ubuntu-go-qml-template/main.qml',
                  'manifest.json',
                  'run.sh',
                  'build.sh',
                  'build-in-chroot.sh'
                  ]

    file_names.each do |fname|
      raise "Error - seems like no fresh checkout of ubuntu-go-qml-template" unless File.exists?(fname)
      text = File.read(fname)
      changed = text.gsub(/ubuntu-go-qml-template/, @options.name)
      if fname == 'manifest.json'
        changed = changed.gsub(/Niklas Wenzel <nikwen.developer@gmail.com>/, "#{@options.author} <#{@options.email}>")
      end
      pp changed if @options.verbose
      File.open(fname, "w") {|f| f.puts changed }
    end

  end

  def rename_dirs
    %w{ src share}.each do |d|
      File.rename "#{d}/ubuntu-go-qml-template", "#{d}/#{@options.name}"
    end
  end

  def rename_files
    fnames = %w{ ubuntu-go-qml-template.apparmor 
        ubuntu-go-qml-template.desktop 
        ubuntu-go-qml-template.goproject
        ubuntu-go-qml-template.png }

    fnames.each do |fname|
      File.rename fname, "#{@options.name}.#{ fname.split('.')[1]}"  
    end
  end

  def finish
    puts "Finished! Yai! - now continue with running: 'chroot-scripts/setup-chroot.sh'"
  end

end

p = TemplateSetup.new(ARGV)
p.run
