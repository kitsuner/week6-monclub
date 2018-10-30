require 'faker'

10.times do |index|
	Gossip.create!(author: Faker::GreekPhilosophers.unique.name, content: Faker::TwinPeaks.quote)
end