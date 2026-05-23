#!/usr/bin/ruby

# This lets the program send requests to the web servers.
require 'net/http'

# This loads the serverhead class so serverstats file can use it.
require './serverhead'


# This is the class inheritance from the serverhead file.
class ServerStats < ServerHead

# This checks if the web server is Apache. 
  def apache?
    return false if empty?
    return @head['server']&.downcase&.include?("apache")
  end

# This checks if the web server is IIS. 
  def iis?
    return false if empty?
    return @head['server']&.downcase&.include?("iis")
  end

# This checks if the web server is Nginx. 
  def nginx?
    return false if empty?
    return @head['server']&.downcase&.include?("nginx")
  end

  def litespeed?
    return false if empty?
    return @head['server']&.downcase&.include?("litespeed")
  end

  def setcookie?
    return false if empty?
    cookie = @head['set-cookie']
    return !cookie.nil? && cookie != ""
  end

end


# check if user gave a file name
if ARGV.length != 1
  puts "Run like this ruby serverstats.rb <hosts_file>"
  exit
end

file = ARGV[0]

total = 0
failed = 0
apache = 0
iis = 0
nginx = 0
litespeed = 0
cookies = 0

File.readlines(file).each do |host|
  host = host.strip
  stats = ServerStats.new(host)

  if stats.empty?
    failed += 1
    next
  end

  total += 1

  apache += 1 if stats.apache?
  iis += 1 if stats.iis?
  nginx += 1 if stats.nginx?
  litespeed += 1 if stats.litespeed?
  cookies += 1 if stats.setcookie?
end

# This displaays the results and percentages for each server type.
puts "Results for data #{total} hosts, #{failed} failed."

def percent(count, total)
  if total == 0
    return 0
  end


((count.to_f / total) * 100).round(2)
end

other = total - (apache + iis + nginx + litespeed)

puts "Apache: #{apache} (#{percent(apache, total)}%)"
puts "IIS: #{iis} (#{percent(iis, total)}%)"
puts "Nginx: #{nginx} (#{percent(nginx, total)}%)"
puts "LiteSpeed: #{litespeed} (#{percent(litespeed, total)}%)"
puts "Other: #{other} (#{percent(other, total)}%)"
puts "Cookies: #{cookies} (#{percent(cookies, total)}%)"
puts "Total with cookies: #{cookies} (#{percent(cookies, total)}%)"
