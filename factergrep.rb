class Factgrep
  require 'pp'

  attr_accessor :data, :search_item, :search_value
  def initialize(document, search_item, search_value)
    @data = {}
    @search_item = search_item
    @search_value = search_value
    build_struct(document)
  end

  def build_struct(document, root = nil, first = true)
    if document.is_a? Array
      document.each do |key|
        unless root
          unless key.is_a? Hash
            @data = @data.merge key.to_s => []
            root = key
          else
            @data = @data.merge key.keys.first.to_s => []
            root = key.keys.first.to_s
          end
        end
        build_struct(key, root, false)
        root = nil if first
      end
    elsif document.is_a? Hash
      document.keys.each do |key|
        if key != @search_item
          build_struct(document[key], root, false)
        else
          @data[root] << document[key]
        end
      end
    end
  end

  def find_value
    res = []
    @data.each do |k, v|
      if v.include? @search_value
        res << k
      end
    end
    res
  end

  def display_simplified
    puts "Simplyfied fact data"
    puts "--------------------"
    pp @data
  end
end

