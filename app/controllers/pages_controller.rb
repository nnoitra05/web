class PagesController < ApplicationController

  def index

    @client = FitbitAPI::Client.new(
      client_id: "238WGS",
      client_secret: "6074c52e649a43a5bdc05682762c5054",
      access_token: ENV["ACCESS_TOKEN"],
      refresh_token: ENV["REFRESH_TOKEN"],
      expires_at: 1234567890,
      user_id: ENV["USER_ID"]
    )

    @graph_data = [
      {name: "weight", data: {
        "2022-10-01" => 75.0,
        "2022-10-02" => 80.0,
        "2022-10-03" => 79.0,
        "2022-10-04" => 79.0,
        "2022-10-05" => 79.0,
        "2022-10-06" => 78.0,
        "2022-10-07" => 78.0
      }}
    ]

    # @weight_logs = @client.weight_logs("2022-10-10")

  end

end
