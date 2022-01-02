class Template
    attr_accessor :name, :generate_io

end

class Interface
    attr_accessor :name, :generate_sb, :wireframe_sb
end

module Initializable

    def initialize(params)
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
    end

end

class Template 
    include Initializable

    def self.types
        [mvvm]
    end

    def self.mvvm
        Template.new({
            name: "MVVM-Module",
            generate_io: false
        })
    end
end

class Interface
    include Initializable

    def self.types
        [none, storyboard]
    end

    def self.default
        none
    end

    def self.storyboard
        Interface.new({
            name: "Storyboard",
            generate_xib: false,
            generate_sb: true,
            wireframe_sb: true
        })
    end
    
    def self.none
        Interface.new({
            name: "UIKit",
            generate_xib: false,
            generate_sb: false,
            wireframe_sb: true
        })
    end
end
