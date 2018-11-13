module Erlash
  module Testing
    class FileAlreadyWrittenError < Erlash::Base
      display_context false
      problem { |context| "File written at: #{context[:filename]}" }
      summary "Review the file and remove second parametter to start testing"
      resolution "expected_message('name'){ |expected| expect(message).to eq(expected) }"
    end

    class MessageNotRegisteredError < Erlash::Base
      display_context false
      problem { |context| "File does not exists at: #{context[:filename]}" }
      summary "Example file is not yet registered please register content as second parametter"
      resolution "expected_message('name', 'content'){ |expected| expect(message).to eq(expected) }"
    end
    class OverrideFileNotAllowedError < Erlash::Base
      display_context false
      problem { |context| "File already exists at: #{context[:filename]}" }
      summary "Example file already exists if you want to override it please remove the file to create a new one"
      resolution { |context| "Remove second parametter Or rm #{context[:filename]}" }
    end

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
      file_exists = File.exists?(filename)
      if message
        if file_exists
          raise OverrideFileNotAllowedError, { filename: filename }
        else
          File.open(filename, 'w') { |f| f.write(message) }
          raise FileAlreadyWrittenError, { filename: filename }
        end
      else
        if file_exists
          block.call(File.read(filename))
        else
          raise MessageNotRegisteredError, { filename: filename }
        end
      end
    end

    private

    def erlash_filename(input)
      erlash_messages_path.join("#{input}.error")
    end

    if defined?(RSpec)
      undef :erlash_filename
      def erlash_filename(input)
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
