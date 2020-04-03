# NSE country scan

Scan a whole country with nmap

## Installation

```bash
git clone https://github.com/mmpx12/nse-country-scan.git
cd nse-country-scan
sudo make
```

## usage

If no argument is pass the script while choose a random country and scan all the ips
Argument are:

- country: "Code of the country in uppercase">
- max_ip: "Number of ip range to scan"

```bash
nmap --script country_scan --script-args 'country=LU, max_ip=2'
# This whill scan 2 range of ip and not 2 ip only
# You can see which one with `HEAD -2 /usr/share/nmap/nselib/country/list/LU`
```

Other ip, script or nmap argument can be pass like:

```bash
nmap -sn --script country_scan --script-args 'country=LU, max_ip=2' 1.1.1.1
```


## Delete

For deleting this script run:

```bash
cd nse-country-scan
sudo make clean
```
