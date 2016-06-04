#!/usr/bin/ruby
# output_workspaces.rb

require 'json'
require 'colorize'

workspaces = JSON.parse(`i3-msg -t get_workspaces`)

totalworkspaces = workspaces.length - 1
order_ws = ['', '', '', '', '', '', '']
order_hash = Hash[order_ws.each_with_index.to_a]
str = ''

for counter in 0..totalworkspaces
    str << workspaces[counter]['name']
end
ws = str.each_char.sort_by { |c| order_hash[c] }.join

for counter in 0..totalworkspaces
	print ws[counter]
	print ' '
end
