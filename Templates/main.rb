#!/usr/bin/env ruby

require 'fileutils'
require './generator'
require './parameters'

PATH = "VIPER Templates"
RESOURCES = "Resources"

def generate_sb(template, interface, source_folder, destination_folder)
    return unless interface.generate_sb
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___.storyboard.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___.storyboard"
end

def generate_mvvmViewController(template, interface, source_folder, destination_folder)
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___ViewController.swift.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___ViewController.swift"
end

def generate_mvvmView(template, interface, source_folder, destination_folder)
    return if (interface.generate_sb == true)
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___View.swift.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___View.swift"
end

def generate_mvvmCoordinator(template, interface, source_folder, destination_folder)
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___Coordinator.swift.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___Coordinator.swift"
end

def generate_mvvmViewModel(template, interface, source_folder, destination_folder)
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___ViewModel.swift.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___ViewModel.swift"
end

def generate_mvvmModel(template, interface, source_folder, destination_folder)
    generator = Generator.new("#{source_folder}/MVVM/___FILEBASENAME___Model.swift.erb", template, interface)
    generator.save "#{destination_folder}/___FILEBASENAME___Model.swift"
end

def generate(template, interface)
    source_folder = "#{RESOURCES}/Templates"
    destination_folder = "#{PATH}/#{template.name}.xctemplate/#{interface.name}"
    generate_sb(template, interface, source_folder, destination_folder)
    generate_mvvmModel(template, interface, source_folder, destination_folder)
    generate_mvvmCoordinator(template, interface, source_folder, destination_folder)
    generate_mvvmViewModel(template, interface, source_folder, destination_folder)
    generate_mvvmView(template, interface, source_folder, destination_folder)
    generate_mvvmViewController(template, interface, source_folder, destination_folder)
end

def generate_info_plist(template)
    generator = Generator.new("#{RESOURCES}/TemplateInfo.plist.erb", template, Interface)
    generator.save "#{PATH}/#{template.name}.xctemplate/TemplateInfo.plist"
end

def copy_images(template)
    source = "#{RESOURCES}/Images/."
    destination = "#{PATH}/#{template.name}.xctemplate"
    FileUtils.cp_r source, destination
end

Template.types.each do |template|
    generate_info_plist template
    copy_images template
    
    Interface.types.each do |interface|
        generate(template, interface)
    end
end
