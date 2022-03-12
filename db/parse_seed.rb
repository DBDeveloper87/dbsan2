f = File.new('parsed_seed.rb', 'w')

chunks = File.foreach('seeds.rb', "\n\n").map(&:rstrip).map{ |s| s.rstrip.split("\n") }

f.puts chunks[0]
f.puts "\n\n"
f.puts chunks[1]
f.puts "\n"

f.puts chunks[2]
f.puts "\n"

f.puts "Number of Total chunks including above: #{chunks.length}\n\n\n"
f.puts "List of following chunks"

chunks[3..57].each do |chunk|
	first_line = chunk[0].split(",")
	state = first_line[0].strip.split("")
	state = state.slice(4..(state.length-2)).join("")
	state_id = first_line[1].split("")
	state_id = state_id.slice(2..(state_id.length-4)).join("")
	f.puts "\t# #{state}, ID: #{state_id}"
	f.puts "\t# Number of Counties #{chunk.length-1}"
	
	chunk[1..(chunk.length)].each do |county|
		f.puts "\t{state_id: \"#{state_id}\", name: \"#{county.strip.split(",")[0]}\"},"
	end
	
	f.puts "\n\n"
end

f.puts "])"


