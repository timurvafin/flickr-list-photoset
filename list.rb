require "rubygems"
require "bundler/setup"
require "flickraw"
require "active_support/all"

FlickRaw.api_key = ARGV.shift
FlickRaw.shared_secret = ARGV.shift

def size(photo_id, label = "Large")
  flickr.photos.getSizes("photo_id" => photo_id).each do |size|
    return size if size["label"] == label
  end
end

flickr.photosets.getPhotos("photoset_id" => ARGV.shift)["photo"].each_with_index do |photo, i|
  info = flickr.photos.getInfo("photo_id" => photo["id"])
  size = size(photo["id"])
  
  print <<EOF
#{sprintf("%02d. #{info["description"]}", i + 1)}  
<a href="#{info['urls'][0]['_content']}" title="#{info["description"]}">
 <img src="#{size['source']}" width="#{size['width']}" height="#{size['height']}" alt="#{info["description"]}">
</a>

EOF

end



