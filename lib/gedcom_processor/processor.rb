# frozen_string_literal: true

# This module is used to parse GEDCOM output to XML
module GedcomProcessor
  class Processor
    def initialize(output)
      @output = output
    end

    def process(file_name)
      begin
        @in_file = File.open(file_name)
      rescue StandardError => e
        @output.puts e.to_s
      end

      return if @in_file.nil?

      name = file_name.split('/')[-1].split("\.")[0]
      out_file_name = File.join(File.dirname(__FILE__), '../../', 'output', "#{name}.xml")
      @out_file = File.new(out_file_name, 'w+')

      parser = Parser.new(@output)
      parser.parse(@in_file, @out_file)

      @in_file.close
      @out_file.close
    end
  end
end
