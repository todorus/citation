module citation

	class Exporter

		#renders an inline citation
		def cite(citation)
			raise "todo implement cite in specific exporter"
		end

		#renders a library entry
		def refer(citation)
			raise "todo implement entry in specific exporter"
		end

	end

end