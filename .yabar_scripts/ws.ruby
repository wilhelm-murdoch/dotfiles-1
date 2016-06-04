#!/usr/bin/ruby
# output_workspaces.rb

require 'json'

workspaces = JSON.parse(`i3-msg -t get_workspaces`)

totalworkspaces = workspaces.length - 1

for counter in 0..totalworkspaces
	if (workspaces[counter]['focused'] == true)
		puts workspaces[counter]['name']
	end
end
