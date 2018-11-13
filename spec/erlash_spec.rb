RSpec.describe Erlash do
  it "has a version number" do
    expect(Erlash::VERSION).not_to be nil
  end

  it 'works' do
    inst = RequestError.new(request_id: '123',
                     user: User.new,
                     endpoint: 'PUT /users/1',
                     params: {email: "another@email.com"})
    expect(inst.message).to eq("")
  end
end
