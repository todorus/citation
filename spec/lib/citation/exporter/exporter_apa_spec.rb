module Citation


	require 'spec_helper'

=begin
	
APA options

narrative: 	if the citation is used inside the narrative or not.
first: 		if it is the first time the citation is mentioned in the text.

TODO
add erroroneus input to the spec (no authors or year specified for example)
add test to see if the cite filters secondary authors
	 
=end


	describe ExporterApa do
	

		before(:each) do
			@exporter = ExporterApa.new
		end

		describe "a single author" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Austin"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(1998, 10, 31)
				}
			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(Austin, 1998)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "Austin (1998)"
				end

			end

		end

		describe "two authors" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Bradley"
						},
						{
							last: "Mokhesi-Parker"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(1998, 10, 31)
				}
			end

			describe "cite" do
				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(Bradley & Mokhesi-Parker, 1998)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "Bradley and Mokhesi-Parker (1998)"
				end

			end

		end

		describe "three to five authors" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Parker"
						},
						{
							last: "Mokhesi-Parker"
						},
						{
							last: "Austin"
						},
						{
							last: "Durkheim"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(1998, 10, 31)
				}
			end

			describe "cite" do

				it "first reference outside narrative" do
					@exporter.cite(@citation, narrative:false, first:true).should == "(Parker, Mokhesi-Parker, Austin & Durkheim, 1998)"
				end

				it "subsequent references outside narrative" do
					@exporter.cite(@citation, narrative:false, first:false).should == "(Parker et al., 1998)"
				end

				it "first reference inside narrative" do
					@exporter.cite(@citation, narrative:true, first:true).should == "Parker, Mokhesi-Parker, Austin and Durkheim (1998)"
				end

				it "subsequent references inside narrative" do
					@exporter.cite(@citation, narrative:true, first:false).should == "Parker et al. (1998)"
				end

			end
		end

		describe "six or more authors" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Harris"
						},
						{
							last: "Parker"
						},
						{
							last: "Mokhesi-Parker"
						},
						{
							last: "Austin"
						},
						{
							last: "Durkheim"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(2001, 10, 31)
				}
			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(Harris et al., 2001)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "Harris et al. (2001)"
				end

			end

		end

		describe "group or corporate authors" do

			before(:all) do
				@citation = {
					authors: [
						{
							last: "Harris"
						},
						{
							last: "Parker"
						},
						{
							last: "Mokhesi-Parker"
						},
						{
							last: "Austin"
						},
						{
							last: "Durkheim"
						}
					],
					title: "About Life the Universe & Everything",
					corporation: "World Bank",
					published: Time.new(2001, 10, 31)
				}



				@citation2 = {
					authors: [
						{
							last: "Harris"
						},
						{
							last: "Parker"
						},
						{
							last: "Mokhesi-Parker"
						},
						{
							last: "Austin"
						},
						{
							last: "Durkheim"
						}
					],
					title: "About Life the Universe & Everything",
					group: "Author group",
					published: Time.new(2001, 10, 31)
				}

			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(World Bank, 2001)"
					@exporter.cite(@citation2, narrative:false).should == "(Author group, 2001)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "World Bank (2001)"
					@exporter.cite(@citation2, narrative:true).should == "Author group (2001)"
				end

			end

		end



		describe "unknown author" do

			before(:all) do

			@citation = {
					title: "About Life the Universe & Everything",
					published: Time.new(2001, 10, 31)
				}

			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(About Life the Universe & Everything, 2001)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "About Life the Universe & Everything (2001)"
				end

			end

		end




		describe "anonymous author" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Anonymous"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(2001, 10, 31)
				}

			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false).should == "(Anonymous, 2001)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true).should == "Anonymous (2001)"
				end

			end

		end



		describe "exact quotation" do

			

			describe "with page numbers" do

				before(:all) do

					@citation = {
						authors: [
							{
								last: "Austin"
							}
						],
						title: "About Life the Universe & Everything",
						published: Time.new(1998, 10, 31),
						page: 211,
						paragraph: 10
					}

				end

				describe "cite" do

					it "outside the narrative" do
						@exporter.cite(@citation, narrative:false).should == "(Austin, 1998, p. 211)"
					end

					it "inside the narrative" do
						@exporter.cite(@citation, narrative:true).should == "Austin (1998, p. 211)"
					end

				end

			end

			describe "without page numbers" do

				before(:all) do

					@citation = {
						authors: [
							{
								last: "Austin"
							}
						],
						title: "About Life the Universe & Everything",
						published: Time.new(1998, 10, 31),
						paragraph: 10
					}

				end

				describe "cite" do

					it "outside the narrative" do
						@exporter.cite(@citation, narrative:false).should == "(Austin, 1998, para. 10)"
					end

					it "inside the narrative" do
						@exporter.cite(@citation, narrative:true).should == "Austin (1998, para. 10)"
					end

				end	

			end

		end


		describe "secondary source" do

			before(:all) do

				@citation = {
					authors: [
						{
							last: "Austin"
						},
						{
							last: "Jones"
						}
					],
					title: "About Life the Universe & Everything",
					published: Time.new(1998, 10, 31),
					secondary: {
						authors: [
							{
								last: "Markinson"
							},
							{
								last: "Peterson"
							},
							{
								last: "Clarckson"
							}
						],
						title: "Conversations with Planet",
						published: Time.new(1976, 10, 31)
					}
				}

			end

			describe "cite" do

				it "outside the narrative" do
					@exporter.cite(@citation, narrative:false, first:true).should == "(Markinson, Peterson & Clarckson as cited in Austin & Jones, 1998)"
				end

				it "inside the narrative" do
					@exporter.cite(@citation, narrative:true, first:true).should == "Markinson, Peterson and Clarckson (as cited in Austin & Jones, 1998)"
				end

			end

		end



	end

end