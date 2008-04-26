require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'fileutils'
require 'ostruct'
require "appscript"
require 'highline/import'
include Appscript

def get_featured_tapes
  doc = Hpricot(open("http://muxtape.com"))
  (doc/"ul.featured a").map{|e| e[:href].scan(/http:\/\/(.*?).muxtape.com/); $1 }.sort
end

HighLine.track_eof = false
$terminal.page_at = 20

def choose_tape
  choose do |m|
    m.prompt = "Which tape would you like"
    m.choices(*get_featured_tapes)
    m.choice(:quit){ say("Orright... Seeya!"); exit(0)}
  end
end

def get_tape 
  choose do |menu|
    menu.prompt = "Would you like to select from the featured playlists or enter your own?" 
    menu.choice(:featured){ say("Loading List.  Please Wait"); choose_tape }
    menu.choice(:custom){ ask("Which One?", String)}
    menu.choice(:quit){   say("Orright... Seeya!"); exit(0)}
  end
end


uri = "http://#{get_tape}.muxtape.com/"

page = Hpricot(open(uri))

muxtape = (page/:h1).inner_text

puts "Downloading #{muxtape}, (#{(page/:h2).inner_text})"

# Get the song names if need be
#song_names = (page/"li.song .name").map do |song|
#  song.inner_text.strip
#end

songs = []  
(page/"script").each do |script|  
  src = script.inner_text  
  if src =~ /new\s+Kettle\(\[([^\]]+)\],\[([^\]]+)\]/  
    ids, codes = [$1, $2].map {|a| a.gsub("'",'').split(",") }  
    ids.zip(codes).each do |ic|  
      songs << OpenStruct.new(:sid =>"#{ic[0]}.mp3", :url => "http://muxtape.s3.amazonaws.com/songs/#{ic[0]}?#{ic[1]}")  
    end  
  end  
end

FileUtils.mkdir_p muxtape

# Keep an array of song files to add to iTunes later
@song_files = []

songs.each_with_index do |song, index|
  puts "Downloading #{index.next} of #{songs.size}"
  song_file =  "#{muxtape}/#{song.sid}"
  open(song.url) do |f|  
    open(song_file,"wb") {|mp3| mp3.write f.read }
  end
  
  @song_files << song_file
end


# Add to iTunes
i_tunes = app('iTunes')
return if i_tunes.playlists[its.name.eq(muxtape)].exists #skip if exists
pl = i_tunes.make(:new => :user_playlist, :with_properties => {:name => muxtape})
@song_files.each do |sf| 
  i_tunes.add(MacTypes::FileURL.path(File.expand_path(File.dirname(__FILE__) + "/#{sf}")),  :to => pl) 
end