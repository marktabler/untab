#!/usr/bin/env ruby
#Untab - written by Mark Tabler on 9/17/10


class TabbedFile
  def initialize (filename)
    @filename = filename
  end

  def read_tabbed_file
    @text = File.read(@filename)
  end 

  def backup_tabbed_file
    if File.exist?(@filename + ".ut_bak")
      File.delete(@filename + ".ut_bak")
    end
    File.rename(@filename, @filename + ".ut_bak")
  end
    
  def untab
    read_tabbed_file
    backup_tabbed_file
    @text.gsub!(/\t/, '  ')
    @text.gsub!(/\r\n/, "\n")
    write_untabbed_file
  end

  def write_untabbed_file
    File.open(@filename, 'w') do |file|
      file.puts @text
    end
  end
  
end

if File.exist?(ARGV[0])
  myfile = TabbedFile.new(ARGV[0])
  myfile.untab
  puts "Untabbing successful."
else
  abort "Aborting! File not found: #{ARGV[0]}"
end
