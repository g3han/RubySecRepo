require 'net/http'
#require "progressbar"
#require "parallel"
require "timeout"

@sleep = (5..7)




@ip_list = File.read("ip_list.txt").split("\n").map { |i| i.strip }.select { |i| !i.empty? }
@path_list = File.read("path_list.txt").split("\n").map { |p| p.strip }.select { |p| !p.empty? }


def check_http(i, path)
  begin
    path = "" if path == "/"
    url = URI.parse("http://#{i}/#{path}")
    req = Net::HTTP::Get.new(url.to_s)


    res = Net::HTTP.start(url.host, url.port, open_timeout: 1) { |http|
      http.read_timeout = 1
      http.ssl_timeout= 1
      http.open_timeout= 1
      http.continue_timeout= 1


      http.request(req)
    }

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      check_http = "#{url}\tOK"
    else
      check_http = "#{url}\t#{res.value}"
    end
  rescue Net::ReadTimeout => e
    check_http = "#{url}\tNOT reachable (ReadTimeout)"
  rescue Net::OpenTimeout => e
    check_http = "#{url}\tNOT reachable (OpenTimeout)"
  rescue => e
    check_http = "#{url}\t#{e.message}"
  end
end

def check_https(i, path)
  begin
    path = "" if path == "/"
    url = URI.parse("https://#{i}/#{path}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, open_timeout: 5,
                          read_timeout: 5,
                          ssl_timeout: 5, :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
      http.request(req)
    }
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      check_https = "#{url}\tOK"
    else
      check_https = "#{url}\t#{res.value}"
    end

  rescue Net::ReadTimeout => e
    check_https = "#{url}\tNOT reachable (ReadTimeout)"
  rescue Net::OpenTimeout => e
    check_https = "#{url}\tNOT reachable (OpenTimeout)"
  rescue => e
    check_https = "#{url}\t#{e.message}"
  end
end