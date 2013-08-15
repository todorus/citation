require "citation/version"
require "citation/exporter/exporter"
require "citation/exporter/exporter_apa"

require "citation/library"
require "citation/scanner/scanner"

#Dir["/citation/exporter/*.rb"].each {|file| require file }

module Citation

	#standard uses the APA exporter
	@@exporter = ExporterApa.new

	module_function
	def cite library, text
		scanned = Scanner.scan text
		
	end

end
