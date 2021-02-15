# RubySecRepo

### 1. NetworkScan 

Usage: 
```sh
$ ruby main.rb 192.168.1.1 192.168.1.3
```


Result:
```sh
192.168.1.1 - 80  -
192.168.1.1 - 443 -
192.168.1.2 - 80  - open
192.168.1.2 - 443 -
192.168.1.3 - 80  - open
192.168.1.3 - 443 -
```
### 2. URLChecker 
Usage: 
```sh
$ ruby main.rb 
```

### 3. Client.rb
Usage:
```sh
For download :> ruby client.rb d [http://CC_ADDRESS] [filename.ext]
For upload   :> ruby client.rb u [http://CC_ADDRESS] [filename.ext]
```
### 4. BulkWhois
Before to use, install parallel and whois gems then put the domain names in list.txt at the same folder with rb file.
```sh
gem install whois
gem install parallel
```
Usage:
```sh
ruby bulkwhois.rb
```
