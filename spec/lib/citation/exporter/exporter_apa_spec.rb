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
							first: "John Hughes",
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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

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

				describe "generates a source reference" do

					#literature
					pending it "for a book" do

					end
					pending it "for an article" do

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

				describe "generates a source reference" do

					#literature
					pending it "for a book" do

					end
					pending it "for an article" do

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

			describe "generates a source reference" do

				#literature
				pending it "for a book" do

				end
				pending it "for an article" do

				end

			end

		end

		describe "other media" do

			#media
			pending it "for a sound recording" do

			end
			pending it "for a video recording" do

			end
			pending it "for television" do

			end

			#online
			pending it "for a web page" do

			end
			pending it "for a blog post" do

			end
			pending it "for an online video" do

			end
			pending it "for a data set" do

			end

		end

		describe "replace" do

			before(:all) do

				citations = [
					{
						id: 2,
						authors: [
							{
								first: "John Hughes",
								last: "Austin"
							}
						],
						title: "About Life the Universe & Everything",
						published: Time.new(1998, 10, 31)
					},
					{
						id:1,
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
					},
					{
						id:3,
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
				]

				@library = Citation::Library.new(citations)

			end

			it "replaces inside the narrative" do
				text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_inside>1</citation_inside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."



				expected = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. Bradley and Mokhesi-Parker (1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				@exporter.replace(@library, text).should == expected
			end

			it "replaces outside the narrative" do
				text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

				expected = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				@exporter.replace(@library, text).should == expected
			end

			it "replaces inside and outside the narrative" do
				text = "Lorem ipsum dolor sit amet <citation_inside>1</citation_inside>, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

				expected = "Lorem ipsum dolor sit amet Bradley and Mokhesi-Parker (1998), consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				@exporter.replace(@library, text).should == expected
			end

			it "replaces multiple citations" do
				text = "Lorem ipsum dolor sit amet <citation_inside>2</citation_inside>,<citation_outside>2</citation_outside> consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

				expected = "Lorem ipsum dolor sit amet Austin (1998),(Austin, 1998) consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				@exporter.replace(@library, text).should == expected
			end

			it "is knowledgeable about the frequency of a citation" do
				text = "Lorem ipsum dolor sit amet <citation_inside>3</citation_inside>,<citation_outside>3</citation_outside> consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

				expected = "Lorem ipsum dolor sit amet Parker, Mokhesi-Parker, Austin and Durkheim (1998),(Parker et al., 1998) consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				@exporter.replace(@library, text).should == expected
			end
		end

	end

end