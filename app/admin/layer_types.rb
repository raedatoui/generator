ActiveAdmin.register LayerType do

	index do
		column :name
		column :slug
		column :icon, :sortable => :icon do |layer_type|
			if layer_type.icon.to_s == ''
				raw('&#8212;')
			else
				image_tag(layer_type.icon, :id => 'icon')
			end
		end
		default_actions
	end

	form :html => { :enctype => "multipart/form-data" } do |f|
		f.inputs "LayerType", :multipart => true do
		f.input :name
		f.input :slug
		f.input :icon, :as => :file
		end
		f.buttons
	end

	show do
		div :class => 'panel' do
			h3 layer_type.slug
			div :class => 'panel_contents' do
				div :class => "attributes_table layer_type", :id => "attributes_layer_type_114" do
					table do
						["name","slug"].each do |column|
							tr do
								th column
								td layer_type.send(column.to_sym).to_s
							end
						end
						tr do
							th "icon"
							if layer_type.icon.to_s.nil?
								td "No image provided"
							else
								td image_tag(layer_type.icon, :id => 'icon')
							end
						end
					end
				end
			end
		end
	end


end
