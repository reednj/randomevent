
require 'randomevent'
require 'minitest/autorun'

class RandomEventTest < Minitest::Test

	def test_default_event
		was_run = false

		RandomEvent.new do |r|
			r.chance :else do
				was_run = true
			end
		end

		assert was_run, 'default block not executed'
	end

	def test_single_event
		was_run = false

		RandomEvent.new do |r|
			r.chance 0.5 do
				was_run = true
			end
			r.chance 0.5 do
				was_run = true
			end
		end

		assert was_run, 'block not executed'
	end

	def test_zero_prob
		was_run = false

		RandomEvent.new do |r|
			r.chance 0.0 do
				was_run = true
			end
		end

		assert !was_run, 'block with zero probablity executed'
	end

	def test_many_runs
		default_chance = 1.0/100.0
		runs_required = 10000
		expected = (default_chance*runs_required) 
		
		exec_count = 0
		else_count = 0

		# ok this test is a bit non-deterministic, because we don't know
		# exactly how many times the events will be triggered, but we can be
		# pretty confident it is going to fall within some sort of range, so
		# we will run assertions against that
		(0...runs_required).each do

			RandomEvent.new do |r|
				r.chance default_chance do
					exec_count += 1
				end

				r.chance :else do
					else_count += 1
				end
			end
		end

		assert exec_count > expected * 0.5, "#{exec_count} executions - expected around #{expected}"
		assert exec_count < expected * 2.0, "#{exec_count} executions - expected around #{expected}"
		assert exec_count + else_count == runs_required, "totals runs should equal #{runs_required}, got #{exec_count + else_count}"
	end

	def test_prob_more_than_1
		# here the probablity of the events adds up to more than
		# 1 - this should throw an error
		assert_raises RuntimeError do 
			RandomEvent.new do |r|
				r.chance 0.8 do
					was_run = true
				end
				r.chance 0.5 do
					was_run = true
				end
			end
		end
	end

end
