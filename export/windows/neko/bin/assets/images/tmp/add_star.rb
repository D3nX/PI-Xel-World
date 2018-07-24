require 'chunky_png'

bg = ChunkyPNG::Image.from_file("background.png")
star = ChunkyPNG::Image.from_file("star.png")

for x in 0...bg.width
	for y in 0...bg.height / 2
		r = rand(10000)
		if r > 100 and r < 102
			bg.compose!(star, x, y + bg.height / 2) rescue ()
		end
	end
end

bg.save("output.png")