module Citation

	class Library

		def initialize citations=[]
			@citations = citations
		end

		def find id
			@citations.select{|c| !c[:id].nil? && c[:id] == id }.first
		end

		def << citation
			add citation
		end

		def add citation
			@citations << citation
		end

		def remove citation
			@citations.delete citation
		end

	end

end