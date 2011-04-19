# FIXME fix all
module Mongoid
  module Layout
    extend ActiveSupport::Concern

    module Configurations
      module Default
        extend ActiveSupport::Concern
        include Mongoid::Document

        included do
          field :x,      :type => Integer, :default => 0
          field :y,      :type => Integer, :default => 0
          field :width,  :type => Integer, :default => 600
          field :height, :type => Integer, :default => 100
        end
      end

      module Padded
        extend ActiveSupport::Concern
        include Mongoid::Document
        include Mongoid::Layout::Configurations::Default

        included do
          field :padding, :type => Integer, :default => 0
        end
      end
    end

    module LayoutBuilder
      extend ActiveSupport::Concern

      module ClassMethods
        def build_layout configuration_module, params
          opts = params.extract_options!

          layout_name = params[0]
          embed_name  = self.name
          class_name  = "#{embed_name}#{layout_name.capitalize}Layout"
          field_name  = "#{layout_name}_layout"

          Object::const_set class_name.intern, Class::new
          layout_class = Object::const_get class_name

          layout_class.class_eval do
            include Mongoid::Document
            include configuration_module

            embedded_in embed_name, :inverse_of => field_name

            opts[:fields].each do |f|
              if f.kind_of? Hash
                field f.keys[0], :type    => Integer, 
                                 :default => f.values[0][:default] || 0
              else
                field f,         :type    => Integer, 
                                 :default => 0
              end
            end if opts[:fields].kind_of? Array
          end

          class_eval do
            embeds_one field_name, :class_name => layout_class.name
            before_create do
              #     self  [field_name] ||=   layout_class .new 
              eval("self.#{field_name} ||= #{layout_class}.new")
            end
          end
        end # ! LAYOUT METHOD
      end
    end


    module Item
      extend  ActiveSupport::Concern
      include Mongoid::Layout::LayoutBuilder

      module ClassMethods
        def default_layout
          layout :view
          layout :form
          layout :filter
        end

        def layout *params
          build_layout Mongoid::Layout::Configurations::Padded, params
        end 
      end
    end

    module Container
      extend  ActiveSupport::Concern
      include Mongoid::Layout::LayoutBuilder

      module ClassMethods
        def default_layout
          layout :view
          layout :form
          layout :filter
        end

        def time_range_extended_layout
          layout :view
          layout :form
          layout :filter, :fields => [{:time_range_x => {:default => 600}},
                                      {:time_range_y => {:default => 100}}]
        end

        def layout *params
          build_layout Mongoid::Layout::Configurations::Default, params
        end
      end
    end 

  end # ! MONGOID LAYOUT MODULE
end # ! MONGOID MODULE
