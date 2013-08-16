module Citation

	class Scanner

		def self.scan(text)
			narrative = text.scan(/<citation_inside>(\d+)<\/citation_inside>/)
			nonnarrative = text.scan(/<citation_outside>(\d+)<\/citation_outside>/)

			narrative = narrative.nil? ? [] : processScan(narrative, true)
			nonnarrative = nonnarrative.nil? ? [] : processScan(nonnarrative, false)

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

		def self.find(citationId, text)
			scan(text, false).select{|m| m[:id] == citationId}
		end

		private
		def self.processScan(matches, narrative=false)
			matches.each_with_index do |m,i|
				matches[i] = {id:m[0].to_i, narrative:narrative}
			end
		end

	end

end