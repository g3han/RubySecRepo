require "whois"
require "parallel"
liste=File.read("list.txt").split("\n")
  Parallel.each(liste, in_threads: 8) do |s|
  begin
  rslt=a=!Whois.whois(s.strip).to_s.include?("No match")
  print "#{s.strip}\t#{rslt}\n"
  rescue
    print "#{s.strip}\tNot Proper or No Response\n"
    end
end