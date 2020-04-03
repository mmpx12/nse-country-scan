build:
	bash ip.sh
	cp country_scan.nse /usr/share/nmap/scripts/.
	nmap --script-updatedb
clean:
	rm -rf /usr/share/nmap/nselib/country
	rm /usr/share/nmap/scripts/country_scan.nse
	rm country_list.lst
	nmap --script-updatedb

