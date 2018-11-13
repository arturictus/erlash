module Erlash
  module Testing
    def self.messages_path=(path)
      @messages_path = path
    end

    def self.messages_path
      @messages_path
    end

    def erlash_messages_path
      @erlash_messages_path ||= Pathname.new(Erlash::Testing.messages_path)
    end

    def expected_message(name, message = nil, &block)
      filename = erlash_filename(name)
      if message
        File.open(filename, 'w') do |f|
          f.write(message)
        end
        raise "File written at: #{filename}. Review file and remove second parametter to start testing"
      else
        if File.exists?(filename)
          block.call(File.read(filename))
        else
          raise 'Error still not generated please add message as second parametter to write it on disc'
        end
      end
    end

    private

    def erlash_filename(input)
      erlash_filename_by_sting(input)
    end

    def erlash_filename_by_sting(input)
      erlash_messages_path.join("#{input}.error")
    end

    if defined?(RSpec)
      def erlash_filename_by_sting(input)
        name = if input.is_a?(RSpec::Core::Example)
                 input.full_description.gsub("\s", "_")
               else
                 input
               end
        erlash_messages_path.join("#{name}.error")
      end
    end
  end
end
