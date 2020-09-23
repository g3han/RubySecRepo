require_relative 'env'

@result = ""
#progressbar = ProgressBar.create(:total => @ip_list.count,:title=>"Checking")



@ip_list.each do |ip|
#Parallel.each(@ip_list, in_threads: 2) do |ip|
 # progressbar.title= "Checking #{ip}"

  @path_list.each do |p|

    @result = "#{check_http(ip, p)}\n"

File.write("result.csv",@result, mode: 'a')
print @result
    @result = "#{check_https(ip, p)}\n"
File.write("result.csv",@result, mode: 'a')
print @result
  end
    sleep(rand(@sleep))
  #progressbar.increment

end



