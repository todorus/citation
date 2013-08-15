module Citation

	require 'spec_helper'

	describe Citation do

		describe "replaces matched id's with the citation" do
			
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
					}
				]

				@library = Library.new(citations)

			end

			context "with apa exporter" do

				it "replaces inside the narrative" do
					text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_inside>1</citation_inside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

					expected = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. Bradley and Mokhesi-Parker (1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
					Citation.cite(@library, text).should == expected
				end

				it "replaces outside the narrative" do
					text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

					expected = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
					Citation.cite(@library, text).should == expected
				end

				it "replaces inside and outside the narrative" do
					text = "Lorem ipsum dolor sit amet <citation_inside>1</citation_inside>, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

					expected = "Lorem ipsum dolor sit amet Bradley and Mokhesi-Parker (1998), consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Bradley & Mokhesi-Parker, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
					Citation.cite(@library, text).should == expected
				end

				it "replaces several sources" do
					text = "Lorem ipsum dolor sit amet <citation_inside>1</citation_inside>, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>2</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."

					expected = "Lorem ipsum dolor sit amet Bradley and Mokhesi-Parker (1998), consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. (Austin, 1998) In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
					Citation.cite(@library, text).should == expected
				end

				pending it "is knowledgeable about the frequency of a citation" do
					#test with apa exporter and first, not first values
				end

			end

		end

	end

end