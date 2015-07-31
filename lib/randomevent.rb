require "randomevent/version"

#
# RandomEvent - a DSL class to make it easy to execute random events
#
# Use the chance method inside the constructor to add an chance 'path'
# the probabilty passed in should be between 0 and 1. You can also pass
# :else. This will be executed if no other blocks are hit
#
# Example:
#
#   # half of the time it will output hello, 25% of the time goodbye
#   # and 25 % of the time the default will be executed
#	Randomizer.new do |r|
#		r.chance 0.5 do
#			puts 'hello'
#		end
#
#		r.chance 0.25 do
#			puts 'goodbye'
#		end
#
#		r.chance :else do
#			puts '-'
#		end
#	end
#
#
class RandomEvent
	def initialize
		@paths = []
		@else_block = nil

		# run the DSL
		yield self
		self.execute
	end

	def chance(prob, &block)
		if prob == :else
			@else_block = block
		elsif prob.kind_of? Numeric
			@paths.push({:p => prob, :block => block})
		end
	end

	def execute
		sum_prob = 0
		v = rand()

		# get the sum of the hash, and make sure the probabilites add up
		total_p = @paths.map {|path| path[:p] }.inject(0, :+)
		raise 'total probability is > 1.0' if total_p > 1

		@paths.each do |path|
			sum_prob += path[:p]

			if v < sum_prob
				path[:block].call
				return
			end
		end

		# we didn't hit anything... call the else block if we have
		# one
		@else_block.call if !@else_block.nil?

	end
end
