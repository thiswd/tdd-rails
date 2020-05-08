describe "HTTParty" do
  # match_requests_on: [:body], usa o conteúdo do body pra verificar se o vcr existe, em vez de usar http method e url
  # it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] }  do

  # record: :new_episodes, sempre que a url mudar, o vcr grava os dados no yml
  # Também tem as opções :none e :all
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes }  do
    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2")
    #   .to_return(status: 200, body: "", headers: { 'content-type': 'application/json' })

    # VCR.use_cassette('jsonplaceholder/posts') do
      response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/4')
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
    # end
  end
end
