module Citation

	class Scanner

		def self.scan(text)
			narrative = text.match(/<citation_inside>(\d+)<\/citation_inside>/)
			nonnarrative = text.match(/<citation_outside>(\d+)<\/citation_outside>/)

			narrative = narrative.nil? ? [] : processScan(narrative.captures.uniq, true)
			nonnarrative = nonnarrative.nil? ? [] : processScan(nonnarrative.captures.uniq, false)

			narrative + nonnarrative
		end

		def self.citations(text)
			sources = scan text

			sources.each do |s|
				matches = text.match /(<citation_rb>#{s}<\/citation_rb>)/

				first = true
				matches.each do |m|


					first = false
				end
			end
		end

		private
		def self.processScan(matches, narrative=false)
			matches.each_with_index do |m,i|
				matches[i] = {id:m.to_i, narrative:narrative}
			end
		end

	end

end