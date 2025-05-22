require 'json'
require 'rails'

module RailsFakeApi
  module JsonFileStore
    def self.file_path_prefix
      @file_path_prefix ||= Rails.root.join('db', 'fake_data')
    end

    def self.read(resource_name)
      file_path = file_path_prefix.join("#{resource_name.singularize}.json")

      return [] unless File.exist?(file_path)

      File.open(file_path, 'r') do |file|
        JSON.parse(file.read)
      rescue JSON::ParserError
        []
      end
    end

    def self.write(resource_name, data)
      file_path = file_path_prefix.join("#{resource_name.singularize}.json")

      File.open(file_path, 'w') do |file|
        file.write(JSON.pretty_generate(data))
      end

      data
    end

    def self.find(resource_name, id)
      data = read(resource_name)

      data.find { |item| item['id'].to_s == id.to_s }
    end

    def self.next_id(resource_name)
      data = read(resource_name)

      return 1 if data.empty?

      data.map { |item| item['id'].to_i }.max + 1
    end
  end
end
