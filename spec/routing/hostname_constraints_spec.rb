require "rails_helper"

describe "ルーティング" do
  example "職員トップページ" do
    config = Rails.application.config.baukis2
    url = "http://#{config[:staff][:host]}/#{config[:staff][:path]}"
    expect(get: url).to route_to(
      host: config[:staff][:host],
      controller: "staff/top",
      action: "index"
    )
  end

  example "ホスト名が対象外ならroutableではない" do
    expect(get: "http://foo.example.com").not_to be_routable
  end

  example "存在しないパスならroutableではない" do
    config = Rails.application.config.baukis2
    expect(get: "http://#{config[:staff][:host]}/xyz").not_to be_routable
  end
end