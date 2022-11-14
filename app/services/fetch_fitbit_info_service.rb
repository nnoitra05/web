

class FetchFitbitInfoService

  USER_ID = ENV["FITBIT_USER_ID"]
  ACCESS_TOKEN = ENV["FITBIT_ACCESS_TOKEN"]
  URL = "https://api.fitbit.com/1/user/#{USER_ID}"

  def self.fetch(api)

    case api

    when FetchFitbitInfoService.apis[:weight] # weight

      prev_30_day = (Date.today.prev_day(30)).strftime("%F")
      droplet_ep = "#{URL}/#{api}/#{prev_30_day}/today.json"
      uri = URI.parse(droplet_ep)

      conn = Faraday.new(url: "#{uri.scheme}://#{uri.host}")

      response = conn.get do |request|
          
        request.url uri.path
        request.headers["Authorization"] = "Bearer #{ACCESS_TOKEN}"

      end
  
      data = JSON.parse(response.body)
  
       weights = {}
  
      data["body-weight"].each do |d|
  
        weights[d["dateTime"]] = d["value"].to_f
  
      end
      
      weight_data = [{name: "weight", data: weights}]

      min_weight = weights.values.min
      max_weight = weights.values.max

      weight_hash = {
        weight: weight_data,
        min: min_weight,
        max: max_weight
      }
      
      return weight_hash

    when FetchFitbitInfoService.apis[:summary] # if summary

      today = (Date.today).strftime("%F")
      droplet_ep = "#{URL}/#{api}/#{today}.json"
      uri = URI.parse(droplet_ep)

      conn = Faraday.new(url: "#{uri.scheme}://#{uri.host}")

      response = conn.get do |request|
          
        request.url uri.path
        request.headers["Authorization"] = "Bearer #{ENV["FITBIT_ACCESS_TOKEN"]}"

      end
  
      data = JSON.parse(response.body)

      summary_hash = {
        current_calories_out: data["summary"]["caloriesOut"],
        goal_calories_out: data["goals"]["caloriesOut"],
        current_steps: data["summary"]["steps"],
        goal_steps: data["goals"]["steps"],

      }

      return summary_hash

    end

  end
  

  def self.apis
  
    return fitbit_apis = {
      weight: "body/weight/date", # weight between date:A and date:B
      summary: "activities/date" # summary by date
    }
  
  end

end