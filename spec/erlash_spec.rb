RSpec.describe Erlash do
  it "has a version number" do
    expect(Erlash::VERSION).not_to be nil
  end

  it 'works' do |e|
    inst = RequestError.new(request_id: '123',
                     user: User.new,
                     endpoint: 'PUT /users/1',
                     params: {email: "another@email.com"})
    expected_message('user_error') do |expected|
      expect(inst.message).to eq(expected)
    end
  end
end
