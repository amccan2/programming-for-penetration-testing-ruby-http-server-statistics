# Ruby HTTP Server Statistics

## Overview
This project was completed for my Programming for Penetration Testing course. The program uses Ruby coding and inheritance to create a reconnaissance tool that gathers HTTP header information from web servers.

The program reads a text file containing multiple domain names, creates `ServerStats` objects to query each domain's web server, and computes summary statistics about the servers. It identifies whether each successful server connection is running Apache, IIS, Nginx, LiteSpeed, or another server type. It also checks whether the server sets cookies.

## Tools Used
- Ruby
- Kali Linux
- gedit
- Linux terminal
- HTTP headers
- Web server hostnames

## How It Works
The program uses a Ruby class named `ServerStats` that inherits from a given HTTP header class. The inherited class grabs HTTP response headers from web servers, and the `ServerStats` class adds methods to check for specific server types and cookies.

The program reads hostnames from `webservers.txt`, checks each host, tracks successful and failed connections, and prints summary statistics with counts and percentages.

## How to Run
This project was created and tested on Kali Linux.

Run the program with:
./serverstats.rb webservers.txt or ruby serverstats.rb webservers.txt 
