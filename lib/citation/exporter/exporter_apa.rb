module Citation

	class ExporterApa < Exporter

		def cite(citation, options)
			
			result = ""
			
			

			if citation[:corporation] || citation[:group]

				group = !citation[:corporation].nil? ? citation[:corporation] : citation[:group]

				if options[:narrative]
					result = "#{group} (#{citation[:published].year})"
				else
					result = "(#{group}, #{citation[:published].year})"
				end

			else

				authorCount = citation[:authors].nil? ? 0 : citation[:authors].length + (citation[:authorsSecondary] != nil ? citation[:authorsSecondary].length : 0)

				if authorCount == 0
					if options[:narrative]
						result = "#{citation[:title]} (#{citation[:published].year})"
					else
						result = "(#{citation[:title]}, #{citation[:published].year})"
					end
				elsif authorCount == 1
					if options[:narrative]
						result = "#{citation[:authors][0][:last]} (#{citation[:published].year})"
					else
						result = "(#{citation[:authors][0][:last]}, #{citation[:published].year})"
					end
				elsif authorCount == 2
					if options[:narrative]
						result = "#{citation[:authors][0][:last]} and #{citation[:authors][1][:last]} (#{citation[:published].year})"
					else
						result = "(#{citation[:authors][0][:last]} & #{citation[:authors][1][:last]}, #{citation[:published].year})"
					end
				elsif authorCount < 6

					if options[:narrative]
						if options[:first]
							
							result = listMultiple(citation[:authors])+" (#{citation[:published].year})"
						else
							result = "#{citation[:authors][0][:last]} et al. (#{citation[:published].year})"
						end
					else
						if options[:first]
							result = "(#{listMultiple(citation[:authors], '&')}, #{citation[:published].year})"
						else
							result = "(#{citation[:authors][0][:last]} et al., #{citation[:published].year})"
						end
					end

				else
					#more than 5
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

	end

end