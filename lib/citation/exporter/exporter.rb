module Citation

	class Exporter

		#renders an inline citation
		def cite(citation, options)
			raise "todo implement cite in specific exporter"
		end

		#renders a library entry
		def refer(citation, options)
			raise "todo implement entry in specific exporter"
		end

	end

end