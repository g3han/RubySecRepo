require 'ipaddr'
require 'socket'
#Usage ruby main.rb 192.168.1.1 192.168.1.3
#rand =random delay second
# port_list= knocking pots
# timeout= port timeout seconds
#
port_list = %w(80 90 22 443 8080 8443 8082 8081)
rand = (3..8)
timeout=1
def convert_ip_range(start_ip, end_ip)
  start_ip = IPAddr.new(start_ip.strip)
  end_ip = IPAddr.new(end_ip.strip)
  (start_ip..end_ip).map(&:to_s)
end
startip = ARGV[0]
endip = ARGV[1]
range = convert_ip_range(startip, endip)
range.each do |ip|
  port_list.each do |port|
    begin
      socket = Socket.tcp(ip, port, connect_timeout: timeout) { |sock|
      }
      status = "open"
    rescue => e
      status = e.message.split(" - ").first
    end
    r="#{ip}\t#{port}\t#{status}\n"
    print r
    File.write('port.csv', r, mode: 'a')
    sleep(rand(rand))
  end
end
