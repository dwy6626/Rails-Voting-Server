RSpec.describe 'authenticate', type: :request do
  let!(:user) { create :user }
  let(:password) { 'mypass' }
  let(:false_password) { 'hispass' }
  let(:false_email) { 'hismail@mail.test' }

  shared_examples 'not got token' do
    it do
      subject
      expect(response.status).to eq(403)
      expect(JSON.parse(response.body)).to eq('status' => 'error', 'error' => 'invalid username or password')
    end
  end

  describe '/api/login' do
    subject { post '/api/login', params: { email: param_email, password: param_password } }

    let(:param_email) { user.email }
    let(:param_password) { password }

    it 'get token' do
      subject
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('status' => 'ok', 'auth_token' => user.auth_token)
    end

    context 'wrong email' do
      let(:param_email) { false_email }
      it_behaves_like 'not got token'
    end

    context 'wrong password' do
      let(:param_email) { false_password }
      it_behaves_like 'not got token'
    end
  end
end
