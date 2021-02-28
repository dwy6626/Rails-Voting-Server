RSpec.describe "Issues", type: :request do
  let!(:issue1) { create :issue }
  let!(:issue2) { create :issue }
  let!(:user) { create :user }
  let(:agree_count1) { 0 }
  let(:disagree_count1) { 0 }
  let(:agree_count2) { 15 }
  let(:disagree_count2) { 7 }

  before do
    create_list :vote, agree_count2, issue: issue2
    create_list :vote, disagree_count2, :disagree, issue: issue2
  end

  let(:issue1_json) do
    {
      'title' => issue1.title,
      'description' => issue1.description,
      'agree_count' => agree_count1,
      'disagree_count' => disagree_count1
    }
  end

  let(:issue2_json) do
    {
      'title' => issue2.title,
      'description' => issue2.description,
      'agree_count' => agree_count2,
      'disagree_count' => disagree_count2
    }
  end

  shared_examples 'view issue 1 result' do
    it do
      subject
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq issue1_json
    end
  end

  shared_examples 'raise 401' do
    it do
      subject
      expect(response.status).to eq 401
      expect(JSON.parse(response.body)).to eq('error' => 'You need to sign in or sign up before continuing.')
    end
  end

  shared_examples 'raise 404' do
    it do
      subject
      expect(response.status).to eq 404
      expect(JSON.parse(response.body)).to eq('error' => 'resource not found')
    end
  end

  describe 'GET /api/issues/:id' do
    subject { get "/api/issues/#{id}" }
    let(:id) { 2 }

    it 'get current voting' do
      subject
      expect(JSON.parse(response.body)).to eq issue2_json
    end

    context 'change id' do
      let(:id) { 1 }
      it_behaves_like 'view issue 1 result'
    end

    context 'invalid id' do
      let(:id) { 3 }
      it_behaves_like 'raise 404'
    end
  end

  describe 'PATCH /api/issues/:id' do
    subject { patch "/api/issues/#{id}", params: { agree: agree, auth_token: auth_token } }
    let(:agree) { true }
    let(:auth_token) {}
    let(:id) { 1 }

    it_behaves_like 'raise 401'

    context 'invalid id and not login' do
      let(:id) { 3 }
      it_behaves_like 'raise 401'
    end

    context 'login user' do
      let(:auth_token) { user.auth_token }

      context 'vote agree' do
        let(:agree_count1) { 1 }

        it 'add vote result' do
          expect { subject }.to change { issue1.agree_count }.by(1)
        end

        it_behaves_like 'view issue 1 result'
      end

      context 'vote disagree' do
        let(:agree) { false }
        let(:disagree_count1) { 1 }

        it 'add vote result' do
          expect { subject }.to change { issue1.disagree_count }.by(1)
        end

        it_behaves_like 'view issue 1 result'
      end

      context 'duplicate voting: disagree -> agree' do
        let!(:vote) { create :vote, :disagree, issue: issue1, user: user }
        let(:agree_count1) { 1 }

        it 'update previous vote' do
          expect { subject }.to change { issue1.disagree_count }.by(-1).and \
            change { issue1.agree_count }.by(1)
        end

        it_behaves_like 'view issue 1 result'
      end

      context 'invalid id' do
        let(:id) { 3 }
        it_behaves_like 'raise 404'
      end
    end
  end

  describe 'GET /api/issues' do
    subject { get '/api/issues' }

    it 'get all issues' do
      subject
      expect(JSON.parse(response.body)).to match_array [issue1_json, issue2_json]
    end
  end
end
