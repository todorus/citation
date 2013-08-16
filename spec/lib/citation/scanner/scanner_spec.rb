module Citation


	require 'spec_helper'

	describe Scanner do

		describe "scans a text for citations" do

			it "finds citations inside the narrative" do
				text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_inside>1</citation_inside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				Scanner.scan(text).should == [{id:1,narrative:true}]
			end
			it "finds citations outside the narrative" do
				text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				Scanner.scan(text).should == [{id:1,narrative:false}]
			end
			it "finds outside and inside citations" do
				text = "Lorem ipsum dolor sit amet <citation_inside>1</citation_inside>, consectetur adipiscing elit. Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis suscipit venenatis, ante ipsum cursus augue."
				Scanner.scan(text).should == [{id:1,narrative:true},{id:1,narrative:false}]
			end

			it "finds mixed citations" do
				text = "Lorem ipsum dolor sit amet <citation_inside>1</citation_inside>, consectetur adipiscing elit.<citation_inside>2</citation_inside><citation_inside>3</citation_inside> Phasellus quis lectus metus, at posuere neque. Sed pharetra nibh eget orci convallis at posuere leo convallis. Sed blandit augue vitae augue scelerisque bibendum. Vivamus sit amet libero turpis, non venenatis urna. <citation_outside>1</citation_outside> In blandit, odio convallis<citation_outside>5</citation_outside> suscipit venenatis, ante ipsum cursus augue."
				Scanner.scan(text).should == [{id:1,narrative:true},{id:2,narrative:true},{id:3,narrative:true},{id:1,narrative:false},{id:5,narrative:false}]
			end

		end



	end

end