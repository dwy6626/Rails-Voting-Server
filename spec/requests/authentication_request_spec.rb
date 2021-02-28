RSpec.describe 'authenticate', type: :request do
  let!(:user) { create :user }
  let(:password) { 'mypass' }
  let(:false_password) { 'hispass' }
  let(:false_email) { 'hismail@mail.test' }

  let(:param_email) { user.email }
  let(:param_password) { password }

  shared_examples 'not got token' do
    it do
      subject
      expect(response.status).to eq(403)
      expect(JSON.parse(response.body)).to eq('status' => 'error', 'error' => 'invalid username or password')
    end
  end

  describe '/api/login' do
    subject { post '/api/login', params: { email: param_email, password: param_password } }



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

  describe '/api/sign_up' do
    subject { post '/api/sign_up', params: { email: param_email, password: param_password } }
    let(:param_email) { 'new@test.test' }

    it 'register user' do
      subject
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq('status' => 'ok')
    end

    context 'existing email' do
      let(:param_email) { user.email }

      it 'raise 409' do
        subject
        expect(response.status).to eq(409)
        expect(JSON.parse(response.body)).to eq('status' => 'error', 'error' => 'email already taken')
      end
    end

    context 'invalid password' do
      let(:param_password) { '' }

      it 'raise 400' do
        subject
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['status']).to eq 'error'
        expect(JSON.parse(response.body)['error']).to include "Password can't be blank"
      end
    end

    context 'invalid email' do
      let(:param_email) { 'not a mail' }

      it 'raise 400' do
        subject
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)['status']).to eq 'error'
        expect(JSON.parse(response.body)['error']).to include 'Email is invalid'
      end
    end
  end
end
