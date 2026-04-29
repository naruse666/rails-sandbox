class GithubService
  BASE_URL = 'https://api.github.com'

  def fetch_user(username)
    uri = URI("#{BASE_URL}/users/#{username}")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      nil
    end
  end
end
