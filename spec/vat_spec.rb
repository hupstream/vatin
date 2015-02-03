
describe 'VATIN app' do

  def app
    App
  end

  describe 'GET /' do
    before { get '/' }
    subject { last_response }
    its(:status) { should eq(200) }
  end

  describe 'GET /api/fr/*' do

    context 'using an unsupported country' do
      before { get '/api/country/' }
      subject { last_response }
      its(:status) { should eq(404) }
    end

    context 'using an empty id' do
      before { get '/api/fr/' }
      subject { last_response }
      its(:status) { should eq(400) }
    end

    context 'using an invalid id' do
      before { get '/api/fr/532' }
      subject { last_response }
      its(:status) { should eq(400) }
    end

    context 'using a valid id' do
      before { get '/api/fr/532262268' }
      subject { last_response }
      its(:status) { should eq(200) }
      it "has valid cache header" do
        expect(last_response.headers['Cache-Control']).to eq('public, max-age=28800')
      end
      its(:body) do
        should eq({
          company_id: '532262268',
          vat: 'FR73532262268',
          validate_url: 'http://ec.europa.eu/taxation_customs/vies/viesquer.do?ms=FR&vat=73532262268'
        }.to_json)
      end
    end
  end
end
