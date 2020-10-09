require 'socket'
require "base64"
require 'uri'
require 'net/http'

#TCP Upload
# f = IO.binread("test.zip")
# b=Base64.encode64(f)
# s = TCPSocket.new '34.71.129.47', 443
# s.puts b
# s.close


def upload (url, f)
#File Upload
  uri = URI(url)
  bin = IO.binread(f)
  bin64 = Base64.encode64(bin)
  response = Net::HTTP.post_form(uri, 'b' => bin64, 'n' => Base64.encode64(f))
  puts response.message
end

def download (url, f)
#File Download
  filename = f
  uri = URI(url)
  response = Net::HTTP.post_form(uri, 'd' => Base64.encode64(filename))
  b = Base64.decode64(response.body)
  IO.binwrite(filename, b)
end

def helper
  print "Usage for download: > d [http://address] [filename.ext]\n"
  print "Usage for upload: > u [http://address] [filename.ext]\n"
end

t = ARGV[0].upcase
u = ARGV[1]
f = ARGV[2]

if t == "U" || t == "UPLOAD"
  upload(u, f)
elsif t == "D" || t == "DOWNLOAD"
  download(u, f)
else
  helper
end