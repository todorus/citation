module Citation

	class ExporterApa < Exporter

		def cite(citation, options)
			
			result = ""
			
			authorString = ""
			yearString = "#{citation[:published].year}"
			positionString = ""

			if citation[:corporation] || citation[:group]
				group = !citation[:corporation].nil? ? citation[:corporation] : citation[:group]
				authorString = "#{group}"
			elsif !citation[:secondary].nil?
				firstoptions = options.clone
				firstoptions[:narrative] = false
				authorString = genAuthorString citation, firstoptions
				authorSecondaryString = genAuthorString citation[:secondary], options
			else
				authorString = genAuthorString citation, options
			end

			if !citation[:page].nil?
				positionString = ", p. #{citation[:page]}"
			elsif !citation[:paragraph].nil?
				positionString = ", para. #{citation[:paragraph]}"
			end

			if options[:narrative]
				if authorSecondaryString.nil?
					result = "#{authorString} (#{yearString}#{positionString})"
				else
					result = "#{authorSecondaryString} (as cited in #{authorString}, #{yearString}#{positionString})"
				end
			else
				if authorSecondaryString.nil?
					result = "(#{authorString}, #{yearString}#{positionString})"
				else
					result = "(#{authorSecondaryString} as cited in #{authorString}, #{yearString}#{positionString})"
				end
			end
				
			return result	
		end

		def refer(citation, options)
			
		end

		private 
		def listMultiple(authors, andsymbol="and")
			result = ""

			length = authors.length
			i = 0
			length.times do						
				if i == length-1
					result += "#{authors[i][:last]}"
				elsif i == length-2
					result += "#{authors[i][:last]} #{andsymbol} "
				else
					result += "#{authors[i][:last]}, "
				end
				i+= 1
			end
			
			result
		end

		def genAuthorString(citation, options)
			
			authorCount = citation[:authors].nil? ? 0 : citation[:authors].length
			if authorCount == 0

				authorString = "#{citation[:title]}"

			elsif authorCount == 1

				authorString = "#{citation[:authors][0][:last]}"

			elsif authorCount == 2

				authorString = listMultiple(citation[:authors], options[:narrative] ? "and" : "&")

			elsif authorCount < 6
				#three to five authors

				if options[:first]
					authorString = listMultiple(citation[:authors], options[:narrative] ? "and" : "&")
				else 
					authorString = "#{citation[:authors][0][:last]} et al."
				end

			else
				#more than five
				authorString = "#{citation[:authors][0][:last]} et al."
			end

			authorString
		end

		def replace citation, text

			

		end

	end

end