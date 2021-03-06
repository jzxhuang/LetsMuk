class ChannelsController < ApplicationController
  include ::AgoraDynamicKey
  require 'net/http'
  require 'uri'
  API_URL = 'https://api.agora.io'.freeze

  def active
    ch_http, ch_request = get_request_objects("#{API_URL}/dev/v1/channel/#{ENV['AGORA_APP_ID']}")
    ch_json = ch_http.request(ch_request).body
    channels = JSON.parse(ch_json)['data']['channels']

    result = []
    channels.each do |channel|
      usrs_http, usrs_request = get_request_objects("#{API_URL}/dev/v1/channel/user/#{ENV['AGORA_APP_ID']}/#{channel['channel_name']}")
      usrs_json = JSON.parse(usrs_http.request(usrs_request).body)
      users = {
        broadcasters: usrs_json['data']['broadcasters'],
        audience: usrs_json['data']['audience']
      }
      channel['users'] = users
      result << channel
    end
    render json: result
  end

  def get_token
    expiration_time_in_seconds = 100000
    opts = {
      app_id: ENV['AGORA_APP_ID'],
      app_certificate: ENV['AGORA_APP_CERTIFICATE'],
      channel_name: params[:channel_name],
      uid: params[:user_id],
      role: AgoraDynamicKey::RtcTokenBuilder::Role::PUBLISHER,
      privilege_expired_ts: Time.now.to_i + expiration_time_in_seconds
    }

    result = AgoraDynamicKey::RtcTokenBuilder.build_token_with_uid(opts)

    render json: result
  end

  private

  def get_request_objects(uri)
    uri = URI.parse(uri)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(ENV['AGORA_KEY'], ENV['AGORA_SECRET'])

    return http, request
  end
end
